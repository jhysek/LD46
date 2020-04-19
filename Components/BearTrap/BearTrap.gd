extends Area2D

var active = true

func deactivate():
	active = false
	$Opened.hide()
	$Closed.show()

func _on_BearTrap_body_entered(body):
	if active and body.is_in_group("Player"):
		deactivate()
		body.die()
		
	if active and body.is_in_group("TrapActivate"):
		deactivate()
