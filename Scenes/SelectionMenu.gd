extends Control

var play_pressed = false
var options_pressed = false
var character = 0
var level = 0
onready var zilly = preload("res://Scenes/Zilly.tscn")

func _ready():
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _process(delta):
	$Characters. frame = character
	$Levels. frame = level



func _on_Character_R_pressed():
	if character < 1:
		character += 1
	else:
		character =0
	
func _on_Character_L_pressed():
	if character > 0:
		character -= 1
	else:
		character = 1

func _on_Level_R_pressed():
	if level < 2:
		level += 1
	else:
		level = 0

func _on_Level_L_pressed():
	if level > 0:
		level -= 1
	else:
		level = 2





func _on_Start_pressed():
	play_pressed = true
	$"/root/TransitionScreen".transition()
	
func _transitioned():
	if play_pressed == true:
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
	if options_pressed == true:
		SceneLoader.goto_scene("res://Scenes/Options.tscn")
		
func _on_Options_pressed():
	options_pressed = true
	$"/root/TransitionScreen".transition()
	
