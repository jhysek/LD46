extends Node

var current_level = 0
var levels = [
	"res://Levels/Level00.tscn",
	"res://Levels/Level01.tscn",
	"res://Levels/Level02.tscn",
	"res://Scenes/Menutscn"
	]

func restart_level():
	print("LOADING LEVEL " + levels[current_level])
	get_tree().change_scene(levels[current_level])
	
func next_level():
	current_level += 1
	if current_level < levels.size():
		restart_level()
