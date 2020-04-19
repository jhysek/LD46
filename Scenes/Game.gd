extends Node2D

var Line = preload("res://Components/Line/Line.tscn")
var last_line = null

var drawing = false
var draw_points = []
var effect
export var bunnies = 1
export var allow_drawing = true

export var paused = true

onready var line = $DrawLine
onready var cam  = $Player/Camera2D

func _ready():	
	if paused:
		if has_node("Players"):
			bunnies = 0
			for player in $Players.get_children():
				bunnies += 1
				player.pause()
		else:
			$Player.pause()
		
	else:
		start_game(false)
		
	set_process_input(true)

func start_game(start_anim = true):
	if start_anim:
		$AnimationPlayer.play_backwards("StartLabel")
		
	paused = false
	if has_node("Players"):
		for player in $Players.get_children():
			player.go()
	else:
		$Player.go()
			
	if has_node("Labels"):
		for label in $Labels.get_children():
			label.start()
		
func next_level():
	$AnimationPlayer.play("NextLevel")

func reached_exit():
	bunnies -= 1
	if bunnies <= 0:
		next_level()

func _input(event):
	if paused and Input.is_action_just_released("ui_accept"):
		start_game()
		
	if allow_drawing and event is InputEventMouseButton:
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
			if last_line:
				last_line.start_fading()
			last_line = l
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
		
	if anim_name == "FadeIn":
		if paused:
			$AnimationPlayer.play("StartLabel")
		
