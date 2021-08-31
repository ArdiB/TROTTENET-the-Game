extends Area2D

signal in_bush
signal not_in_bush


func _on_Bush_body_entered(body):
	$Particles2D.emitting = true
	emit_signal("in_bush")
	

func _on_Bush_body_exited(body):
	$Particles2D.emitting = false
	emit_signal("not_in_bush")
	

