extends Node2D

var new_score
var charactername
var time = 0
var character 


func _ready():
	_load_character()
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))
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
	
func set_score():
	time = $CanvasLayer/Timer.text
	$"/root/Highscores".time = time
	var characterscore = get_tree().get_nodes_in_group("Character")
	for character in characterscore:
		charactername = character.charactername
	new_score = str(time,"  -  ",charactername )
	$"/root/Highscores".new_score = new_score
	$"/root/Highscores".update_space_score()
	


func _on_AsteroidTimer_timeout():
	#spawn asteroid at characterposition + vector2
	var randomnumber = [5, -25]
	var characterposition = get_tree().get_nodes_in_group("Character")
	for character in characterposition:
		characterposition = character.position
	var asteroid_path = "res://Items/Asteroid.tscn"
	var asteroid_resource = load (asteroid_path)
	var asteroid = asteroid_resource.instance()
	asteroid. position = characterposition + Vector2(200, randomnumber[randi() % randomnumber.size()])
	add_child(asteroid)
	
	



func _on_SaveArea_body_entered(body):
	$"/root/TransitionScreen".transition()
	
func _transitioned():
	var characterposition = get_tree().get_nodes_in_group("Character")
	for character in characterposition:
		characterposition = character.position
		character.position +=  Vector2(-150, -300)
		
	var cloud_path = "res://Items/SaveCloud.tscn"
	var cloud_resource = load (cloud_path)
	var cloud = cloud_resource.instance()
	cloud.position = characterposition + Vector2(-150, -290)
	add_child(cloud)
