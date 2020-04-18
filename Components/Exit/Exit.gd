extends Area2D

onready var game = get_node("/root/Game")




func _on_Exit_body_entered(body):
	if body.is_in_group("Player"):
		body.reached_exit()
		game.reached_exit()
