extends Area2D

signal on_collect


var value = 1

func _ready():
	pass # Replace with function body.



func _on_Coin_body_entered(body):
	emit_signal("on_collect", value)
	$AnimationPlayer.play("disappear")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "disappear":
		queue_free()
