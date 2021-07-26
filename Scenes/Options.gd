extends Control

var menu_pressed = false
var fertig_pressed = false
var SoundValue =0

func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _on_HSlider_value_changed(value):
	SoundValue = $Buttons/Sound/HSlider.value




func _on_Menu_pressed():
	menu_pressed = true
	$"/root/TransitionScreen".transition()
	



func _on_Fertig_pressed():
	fertig_pressed = true
	$"/root/TransitionScreen".transition()


func _transitioned():
	if menu_pressed == true:
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
	if fertig_pressed == true:
		get_tree().quit()
