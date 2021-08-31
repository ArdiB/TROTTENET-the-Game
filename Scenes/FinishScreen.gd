extends CanvasLayer

var menu_pressed = false
var highscores_pressed = false

func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _transitioned():
	get_tree().paused = false
	if menu_pressed == true:
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
	if highscores_pressed == true:
		SceneLoader.goto_scene("res://Scenes/Highscores.tscn")

func _on_Menu_pressed():
	menu_pressed = true
	TransitionScreen.transition()

func _on_Highscores_pressed():
	highscores_pressed = true
	TransitionScreen.transition()
