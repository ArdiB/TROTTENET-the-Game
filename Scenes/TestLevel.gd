extends Node2D


var character 
var time = 0

func _ready():
	_load_character()
	

func _process(delta):

	check_key_input()
	
func check_key_input():
	if Input. is_action_just_pressed("reload"):
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")	






func _load_character():
	var character_scene = load (character)
	var character_instance = character_scene.instance()
	character_instance. position = $CharacterPosition.position
	add_child(character_instance)
