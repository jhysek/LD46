extends Sprite


var SPEED = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= SPEED * delta
	
	if position.y < -800:
		queue_free()
