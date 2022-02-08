extends Control


var character = 0
var level = 0
var start_pressed = false
var highscores_pressed = false

onready var zilly = preload("res://Scenes/Players/Zilly.tscn")
onready var happy = preload("res://Scenes/Players/Happy.tscn")

func _ready():
	$"/root/SoundManager".maintheme()
	character = $"/root/VarSaves".character
	$Characters.frame = character
	level = $"/root/VarSaves".level
	$Levels.frame = level
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _on_Character_R_pressed():
	if character < 8:
		character += 1
	else:
		character =0
	$Characters. frame = character
	$"/root/VarSaves".character = character
	
func _on_Character_L_pressed():
	if character > 0:
		character -= 1
	else:
		character = 8
	$Characters. frame = character
	$"/root/VarSaves".character = character

func _on_Level_R_pressed():
	if level < 2:
		level += 1
	else:
		level = 0
	$Levels. frame = level
	$"/root/VarSaves".level = level

func _on_Level_L_pressed():
	if level > 0:
		level -= 1
	else:
		level = 2
	$Levels. frame = level
	$"/root/VarSaves".level = level





func _on_Start_pressed():
	start_pressed = true
	$"/root/TransitionScreen".transition()
	
func _transitioned():
	if start_pressed == true:
		if character == 0:
			var properties = {
				"character": "res://Scenes/Players/Zilly.tscn"
			}

			if level == 0:
				SceneLoader.goto_scene("res://Scenes/Levels/Level1.tscn", properties)
			if level == 1:
				SceneLoader.goto_scene("res://Scenes/Levels/Level2.tscn", properties)
			if level == 2:
				SceneLoader.goto_scene("res://Scenes/Levels/Level3.tscn", properties)
			
		if character == 1:
			#return
			var properties = {
				"character": "res://Scenes/Players/Happy.tscn"
			}

			if level == 0:
				SceneLoader.goto_scene("res://Scenes/Levels/Level1.tscn", properties)
			if level == 1:
				SceneLoader.goto_scene("res://Scenes/Levels/Level2.tscn", properties)
			if level == 2:
				SceneLoader.goto_scene("res://Scenes/Levels/Level3.tscn", properties)
				
	if highscores_pressed == true:
		SceneLoader.goto_scene("res://Scenes/Highscores.tscn")
		
				
func _on_Options_pressed():
	var options_path = "res://Scenes/OptionsMenu.tscn"
	var options_resource = load(options_path)
	var options = options_resource.instance()
	add_child(options)
	get_tree().paused = true


func _on_Highscores_pressed():
	var highscores_path = "res://Scenes/Highscores.tscn" 
	var highscores_resource = load(highscores_path)
	var highscores = highscores_resource.instance()
	add_child(highscores)
	get_tree().paused = true

