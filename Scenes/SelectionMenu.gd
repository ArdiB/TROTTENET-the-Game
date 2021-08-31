extends Control


var character = 0
var level = 0
var start_pressed = false
var highscores_pressed = false

onready var zilly = preload("res://Scenes/Zilly.tscn")

func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))
	$"Character R".grab_focus()

func _on_Character_R_pressed():
	if character < 1:
		character += 1
	else:
		character =0
	$Characters. frame = character
	
func _on_Character_L_pressed():
	if character > 0:
		character -= 1
	else:
		character = 1
	$Characters. frame = character

func _on_Level_R_pressed():
	if level < 2:
		level += 1
	else:
		level = 0
	$Levels. frame = level

func _on_Level_L_pressed():
	if level > 0:
		level -= 1
	else:
		level = 2
	$Levels. frame = level





func _on_Start_pressed():
	start_pressed = true
	$"/root/TransitionScreen".transition()
	
func _transitioned():
	if start_pressed == true:
		if character == 0:
			var properties = {
				"character": "res://Scenes/Zilly.tscn"
			}
			if level == 0:
				SceneLoader.goto_scene("res://Scenes/TestLevel.tscn", properties)
			if level == 1:
				SceneLoader.goto_scene("res://Scenes/Level2.tscn", properties)
		if character == 1:
			var properties = {
				"character": "res://Scenes/Player.tscn"
			}
			if level == 0:
				SceneLoader.goto_scene("res://Scenes/TestLevel.tscn", properties)
	if highscores_pressed == true:
		SceneLoader.goto_scene("res://Scenes/Highscores.tscn")
		
				
func _on_Options_pressed():
	var options_path = "res://Scenes/OptionsMenu.tscn"
	var options_resource = load(options_path)
	var options = options_resource.instance()
	add_child(options)
	get_tree().paused = true


func _on_Highscores_pressed():
	highscores_pressed = true
	$"/root/TransitionScreen".transition()
