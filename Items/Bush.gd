extends Area2D



func _on_Bush_body_entered(body):
	$Particles2D.emitting = true

func _on_Bush_body_exited(body):
	$Particles2D.emitting = false


