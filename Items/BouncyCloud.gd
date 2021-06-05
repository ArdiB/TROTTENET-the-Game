extends Node2D


func _physics_process(delta):
	$Path2D/PathFollow2D.set_offset($Path2D/PathFollow2D.get_offset()+50*delta)
