extends KinematicBody2D

export var SPEED = 8000
export var GRAVITY = 2000

var paused = false
var motion = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY * delta
	motion.x = SPEED * delta
	motion = move_and_slide(motion, Vector2.UP)
