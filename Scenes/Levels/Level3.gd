extends Node2D

var new_score
var charactername
var time = 0
var character
var goal = 0

func _ready():
	$"/root/TransitionScreen".connect("transitioned2", self, ("_transitioned"))
	listen_for_coins()
	_load_character()
	get_tree().paused = true
	camera_settings()
	
func _process(_delta):
	if Input. is_action_just_pressed("ACCEPT"):
		$test.current = true
	

	check_key_input()
	
func check_key_input():
	if Input. is_action_just_pressed("reload"):
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")




func _load_character():
	var character_scene = load (character)
	var character_instance = character_scene.instance()
	character_instance. position = $CharacterPosition.position
	add_child(character_instance)
	move_child(character_instance, 5)
	


func _on_Options_pressed():
	var options_path = "res://Scenes/OptionsMenu.tscn"
	var options_resource = load(options_path)
	var options = options_resource.instance()
	add_child(options)
	get_tree().paused = true




func _on_FinishLine_body_entered(body):
	if body.is_in_group("Character"):
		set_score()
		
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
	$"/root/Highscores".update_city_score()
	

func camera_settings():
	var settings = get_tree(). get_nodes_in_group("Camera")
	for Camera in settings:
		Camera.limit_left = -11000
		Camera.limit_top = -400
	



func listen_for_coins():
	var coins = get_tree(). get_nodes_in_group("coin")
	for coin in coins:
		coin.connect("on_collect", self, "on_coin_collected")
		
func on_coin_collected(value):
	goal += 1
	$CanvasLayer/GoalCounter.text = str(goal, "/", 10)
	if goal == 10:
		set_score()
			
		var finishscreen_path = "res://Scenes/FinishScreen.tscn"
		var finishscreen_resource = load (finishscreen_path)
		var finishscreen = finishscreen_resource.instance()
		add_child(finishscreen)
		get_tree().paused = true
	
		


func _on_Countdown_start():
	$"/root/SoundManager".level3()
