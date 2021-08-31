extends CanvasLayer

var menu_pressed = false
var fertig_pressed = false
var SoundValue = 0

func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))
	if get_tree().get_current_scene().name == "SelectionMenu":
		$Buttons/Menu.visible = false
	$Buttons/Witer.grab_focus()

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
		self. queue_free()
		get_tree().paused = false
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
	if fertig_pressed == true:
		get_tree().quit()
		
func _on_Witer_pressed():
	get_tree().paused = false
	self. queue_free()


func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
