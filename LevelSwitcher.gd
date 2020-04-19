extends Node

var current_level = 0
var levels = [
	"res://Levels/Level00.tscn",
	"res://Levels/Level01.tscn",
	"res://Levels/Level02.tscn",
	"res://Levels/Level03.tscn",
	"res://Levels/Level04.tscn",
	"res://Levels/Level05.tscn",
	"res://Levels/Level06.tscn",
	"res://Levels/Level07.tscn",
	"res://Levels/Level08.tscn",
	"res://Scenes/Menu.tscn"
	]
	
func _ready():
	set_process_input(true)
	
func _input(event):
	if Input.is_action_just_released("ui_restart"):
		restart_level()

func restart_level():
	get_tree().reload_current_scene()
	
func start_level():
	get_tree().change_scene(levels[current_level])
	
func next_level():
	current_level += 1
	if current_level < levels.size():
		start_level()
