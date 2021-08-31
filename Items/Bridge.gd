extends StaticBody2D

var on_bridge = false

func _process(delta):
	if on_bridge == true:
		$AnimatedSprite.playing = true
		$CollisionPolygon2D.disabled = true
		

func _on_Area2D_body_entered(body):
	$"/root/SoundManager".crash()
	on_bridge = true
