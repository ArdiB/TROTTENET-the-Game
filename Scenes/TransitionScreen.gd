extends CanvasLayer

signal transitioned
signal transitioned2

		
		
func transition():
	$ColorRect.visible = true
	$AnimationPlayer.play("fade_to_black")




	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal")
	if anim_name == "fade_to_normal":
		$ColorRect.visible = false
		emit_signal("transitioned2")
