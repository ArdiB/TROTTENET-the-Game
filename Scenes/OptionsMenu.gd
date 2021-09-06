extends CanvasLayer

var menu_pressed = false
var fertig_pressed = false
var fullscreen = false

func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))
	if get_tree().get_current_scene().name == "SelectionMenu":
		$Buttons/Menu.visible = false
		
	$Buttons/Sound/SoundSlider.value = $"/root/Settings".sound_volume
	$Buttons/Musig/MusigSlider.value = $"/root/Settings".music_volume
		
	if OS.window_fullscreen == true:
		$Buttons/Fullscreen/Checkbox.frame = 0
	else:
		$Buttons/Fullscreen/Checkbox.frame = 1
	

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


	


func _on_Fullscreen_pressed():
	
	OS.window_fullscreen = !OS.window_fullscreen
	fullscreen = OS.window_fullscreen
	if OS.window_fullscreen == true:
		$Buttons/Fullscreen/Checkbox.frame = 0
	else:
		$Buttons/Fullscreen/Checkbox.frame = 1
	$"/root/VarSaves".fullscreen = fullscreen
	
	
	


func _on_SoundSlider_value_changed(value):
	$"/root/Settings".sound_volume = $Buttons/Sound/SoundSlider.value


func _on_MusigSlider_value_changed(value):
	$"/root/Settings".music_volume = $Buttons/Musig/MusigSlider.value
