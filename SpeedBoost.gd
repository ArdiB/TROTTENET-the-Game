extends Area2D





func _on_SpeedBoost_area_entered(area):
	if area.name.begins_with("Player"):
		$AnimatedSprite.playing = true


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false
