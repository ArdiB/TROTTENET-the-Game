extends Area2D

export var look = 0

signal on_ramp
signal not_on_ramp

func _ready():
	$Sprite.frame = look

func _on_Ramp_body_entered(body):
	emit_signal("on_ramp")


func _on_Ramp_body_exited(body):
	emit_signal("not_on_ramp")
