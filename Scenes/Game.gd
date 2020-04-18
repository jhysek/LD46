extends Node2D

var Line = preload("res://Components/Line/Line.tscn")

var drawing = false
var draw_points = []
var effect
export var bunnies = 1

onready var line = $DrawLine
onready var cam  = $Player/Camera2D

func _ready():	
	set_process_input(true)

func next_level():
	$AnimationPlayer.play("NextLevel")

func reached_exit():
	bunnies -= 1
	if bunnies <= 0:
		next_level()

func _input(event):
	if event is InputEventMouseButton:
		var pos = get_global_mouse_position()
		#var pos = event.position - cam.position - cam.offset 
		if event.pressed:
			line.clear_points()
			drawing = true
			draw_points.append(pos)
			line.add_point(pos)
		else:
			drawing = false
			draw_points.append(pos)
			line.add_point(pos)
			var l = Line.instance()
			$Obstacles.add_child(l)
			l.draw(draw_points)
			$DrawLine.clear_points()
			draw_points.clear()
									
	if event is InputEventMouseMotion and drawing:
		#var pos = event.position - cam.position
		var pos = get_global_mouse_position()
		draw_points.append(pos)
		line.add_point(pos)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "NextLevel":
		LevelSwitcher.next_level()
