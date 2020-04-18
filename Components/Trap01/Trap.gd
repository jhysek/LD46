extends KinematicBody2D

export var GRAVITY = 2000
var motion = Vector2(0, 0)

func _ready():
	set_physics_process(true)

	
func _physics_process(delta):
	motion.y += GRAVITY * delta
	move_and_collide(motion)


func _on_DeathArea_body_entered(body):
	if body.is_in_group("Player"):
		body.die()
