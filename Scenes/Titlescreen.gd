extends Control


func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))
func _process(_delta):
	_continue()
	
	
func _continue():
	if Input. is_action_just_pressed("ACCEPT"):
		$shootingstar.playing = true
		$Titlescreen/PressEnter.visible = false
		#SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
func _on_shootingstar_animation_finished():
	TransitionScreen.transition()
	

func _transitioned():
	SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
