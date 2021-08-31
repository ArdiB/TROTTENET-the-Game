extends Node2D


var character 


func _ready():
	_load_character()
	get_tree().paused = true
	
func _process(_delta):

	check_key_input()
	
func check_key_input():
	if Input. is_action_just_pressed("reload"):
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")	




func _load_character():
	var character_scene = load (character)
	var character_instance = character_scene.instance()
	character_instance. position = $CharacterPosition.position
	add_child(character_instance)
	move_child(character_instance, 2)
	


func _on_Options_pressed():
	var options_path = "res://Scenes/OptionsMenu.tscn"
	var options_resource = load(options_path)
	var options = options_resource.instance()
	add_child(options)
	get_tree().paused = true




func _on_FinishLine_body_entered(body):
	var finishscreen_path = "res://Scenes/FinishScreen.tscn"
	var finishscreen_resource = load (finishscreen_path)
	var finishscreen = finishscreen_resource.instance()
	add_child(finishscreen)
	get_tree().paused = true
	
