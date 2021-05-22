extends Control

var SoundValue =0


func _on_HSlider_value_changed(value):
	SoundValue = $Buttons/Sound/HSlider.value




func _on_Menu_pressed():
	SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")



func _on_Fertig_pressed():
	get_tree().quit()
