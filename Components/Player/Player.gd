extends KinematicBody2D

export var SPEED = 8000
export var GRAVITY = 2000

var direction = 1

var paused = false
var dead = false
var motion = Vector2(0, 0)
var turntimer = -1
var prevx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY * delta

	if not dead and not paused:
		motion.x = direction * SPEED * delta
		
	if dead:
		motion.x = lerp(motion.x, 0, 2 * delta)

	motion = move_and_slide(motion, Vector2.UP)

	if dead:
		return
		
	if (direction == 1 and prevx < position.x) or (direction == -1 and prevx > position.x):
		prevx = position.x
		turntimer = 0
	else:
		prevx = position.x
		turntimer += delta
		
	if turntimer > 0.5:
		turntimer = 0
		scale.x *= -1
		direction *= -1
	
func die():
	$AnimationPlayer.play("Death")
	dead = true	
	
func dissolve():
	$AnimationPlayer.play("Dissolve")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dissolve":
		queue_free()
		
func reached_exit():
	queue_free()
