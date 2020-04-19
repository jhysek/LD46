extends Node2D

func _ready():
	$TileMap/Player.go()

func _on_Button_mouse_entered():
	$Sfx/Hover.play()


func _on_Button_mouse_exited():
	$Sfx/Hover.play()


func _on_Button_pressed():
	$Sfx/Click.play()
	get_tree().change_scene("res://Levels/Level00.tscn")
	
	
func failed():
	pass
