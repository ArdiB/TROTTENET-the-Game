extends Control


var END
var STR
var SPE

func _ready():
	pass # Replace with function body.



func _on_END_mouse_entered():
	$Label.rect_position = Vector2(0,8)
	$Label.text = str ("ENDURANCE:\nwie schnell d´ Energie\nregeneriert")
	$Label.visible = true
	change_background()
	$Background.visible = true


func _on_END_mouse_exited():
	$Label.visible = false
	$Background.visible = false


func _on_STR_mouse_entered():
	$Label.rect_position = Vector2(0,21)
	$Label.text = str ("STRENGTH:\nstärchi vo de\nBeschlünigung")
	$Label.visible = true
	change_background()
	$Background.visible = true


func _on_STR_mouse_exited():
	$Label.visible = false
	$Background.visible = false


func _on_SPE_mouse_entered():
	$Label.rect_position = Vector2(0,34)
	$Label.text = str ("SPEED:\nmaximali Gschindigkeit")
	$Label.visible = true
	change_background()
	$Background.visible = true


func _on_SPE_mouse_exited():
	$Label.visible = false
	$Background.visible = false

func change_background():
	$Background.rect_position = $Label.rect_position
	$Background.rect_size = $Label.rect_size
