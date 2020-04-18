extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Stone_body_entered(body):
	print(linear_velocity)
	if body.is_in_group("Player") and (linear_velocity.x > 10 or linear_velocity.y > 10):
		body.die()
