extends Node2D

onready var coin_label: Label = $GUI/VBoxContainer/Coin_label

var character 
var time_sec = 0
var time_min = 0

func _ready():
	_load_character()
	

func _process(delta):

		
	check_key_input()

func check_key_input():
	if Input. is_action_just_pressed("reload"):
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")	

func _on_Timer_timeout():
	time_sec += 1
	if time_sec == 60:
		time_min += 1
		time_sec -=60
	_update_time()
	
func _update_time():
	$GUI/VBoxContainer/Timer.text = str ("Time: ", time_min, ":", time_sec)

func _load_character():
	var character_scene = load (character)
	var character_instance = character_scene.instance()
	character_instance. position = $CharacterPosition.position
	add_child(character_instance)
