extends Sprite

var speed = 30
var cloud_scale = 0.6
var delay = 0

func _ready():
	randomize_cloud()
	delay = 0
	set_process(true)

func _process(delta):
	if delay > 0:
		delay -= delta
	else:
		position.x = position.x + speed * delta
	
		if position.x > get_viewport().size.x + 300:
			randomize_cloud()
			position = Vector2(-2000, - randi() % 150 - 200)

func randomize_cloud():
	cloud_scale = randi() % 2 / 2 + 0.6
	#scale = Vector2(cloud_scale, cloud_scale)
	speed = randi() % 15 + 10
	delay = randi() % 10
