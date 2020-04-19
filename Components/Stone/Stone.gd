extends RigidBody2D

var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if abs(linear_velocity.x) > 20:
		if not playing:
			$Rolling.volume_db = 0
			playing = true
			$Rolling.play()
	if abs(linear_velocity.x) > 15:
		$Rolling.volume_db = -10
	else:
		if playing:
			playing = false
			$Rolling.stop()
		

func _on_Stone_body_entered(body):
	if body.is_in_group("Player") and (linear_velocity.x > 10 or linear_velocity.y > 10):
		body.die()
