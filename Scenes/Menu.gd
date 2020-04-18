extends Node2D


func _on_Button_mouse_entered():
	$Sfx/Hover.play()


func _on_Button_mouse_exited():
	$Sfx/Hover.play()


func _on_Button_pressed():
	$Sfx/Click.play()
	get_tree().change_scene("res://Scenes/Game.tscn")
