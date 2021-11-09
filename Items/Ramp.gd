extends Area2D

export var look = 0

signal on_ramp
signal not_on_ramp

func _ready():
	$Sprite.frame = look

