extends KinematicBody2D

export var SPEED = 8000
export var GRAVITY = 2000

var Ghost = preload("res://Components/BunnyGhost/Angel.tscn")

export var direction = 1
var airtime = 0

var paused = false
var dead = false
var motion = Vector2(0, 0)
var turntimer = -1
var prevx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	if direction == -1:
		scale.x *= -1
		
func pause():
	$AnimationPlayer.stop()
	paused = true
	
func go():
	$AnimationPlayer.play("Run")
	paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY * delta
	
	if is_on_floor() or is_on_wall():
		if airtime > 0.5:
			die()
		airtime = 0
	else:
		airtime += delta
		

	if not dead and not paused:
		motion.x = direction * SPEED * delta
		
	if dead:
		motion.x = lerp(motion.x, 0, 2 * delta)

	motion = move_and_slide(motion, Vector2.UP)

	if dead or paused:
		return
		
	if (direction == 1 and round(prevx) < round(position.x)) or (direction == -1 and round(prevx) > round(position.x)):
		prevx = position.x
		turntimer = 0
	else:
		prevx = position.x
		turntimer += delta
		
	print(prevx)
	print(position.x)
	if turntimer > 0.5:
		turntimer = 0
		scale.x *= -1
		direction *= -1
	
func die():
	$AnimationPlayer.play("Death")
	var ghost = Ghost.instance()
	get_parent().add_child(ghost)
	ghost.position = position
	dead = true	
	get_node("/root/Game/AnimationPlayer").play("RestartLabel")
	
func dissolve():
	$AnimationPlayer.play("Dissolve")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dissolve":
		queue_free()
		
func reached_exit():
	queue_free()
