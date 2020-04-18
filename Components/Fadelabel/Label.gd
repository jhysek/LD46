extends Node2D

export var show_after = 0
export var hide_after = 0
export var text = ""


func _ready():
	$Label.modulate = Color(1, 1, 1, 0)
	$Label.text = text.replace("|", "\n")
	if show_after > 0:
		$Timer.wait_time = show_after
		$Timer.start()	
	else:
		fadein()

	if hide_after > 0:
		$HideTimer.wait_time = hide_after
		$HideTimer.start()
		
func fadein():
	$AnimationPlayer.play("FadeIn")
	
func fadeout():
	print("FADING OUT")
	$AnimationPlayer.play_backwards("FadeIn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeIn":
		$AnimationPlayer.play("Idle")
		
	if anim_name == "FadeOut":
		queue_free()

func _on_Timer_timeout():
		fadein()
	
func _on_HideTimer_timeout():
	fadeout()
