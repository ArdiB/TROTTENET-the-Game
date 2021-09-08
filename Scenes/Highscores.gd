extends Node2D

onready var background = get_node("Background")
func _ready():
	update_labels()
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _on_Forest_pressed():
	background.frame = 0
	$ForestScores.visible = true
	$SpaceScores.visible = false

func _on_Space_pressed():
	background.frame = 1
	$ForestScores.visible = false
	$SpaceScores.visible = true
func _on_City_pressed():
	background.frame = 2

func _on_InProgress_pressed():
	background.frame = 3


func _on_Menu_pressed():
	TransitionScreen.transition()
	
func _transitioned():
	SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")

func update_labels():
	#forest_level_labels
	$ForestScores/forestScore01.text = str("1.    ", $"/root/Highscores".forest_score_01)
	if $"/root/Highscores".forest_score_01 == str (1000):
		$ForestScores/forestScore01.text = str("-")
	$ForestScores/forestScore02.text = str("2.    ", $"/root/Highscores".forest_score_02)
	if $"/root/Highscores".forest_score_02 == str (1000):
		$ForestScores/forestScore02.text = str("-")
	$ForestScores/forestScore03.text = str("3.    ", $"/root/Highscores".forest_score_03)
	if $"/root/Highscores".forest_score_03 == str (1000):
		$ForestScores/forestScore03.text = str("-")
		
	#space_level_labels
	$SpaceScores/SpaceScore01.text = str("1.    ", $"/root/Highscores".space_score_01)
	if $"/root/Highscores".space_score_01 == str (1000):
		$SpaceScores/SpaceScore01.text = str("-")
	$SpaceScores/SpaceScore02.text = str("2.    ", $"/root/Highscores".space_score_02)
	if $"/root/Highscores".space_score_02 == str (1000):
		$SpaceScores/SpaceScore02.text = str("-")
	$SpaceScores/SpaceScore03.text = str("3.    ", $"/root/Highscores".space_score_03)
	if $"/root/Highscores".space_score_03 == str (1000):
		$SpaceScores/SpaceScore03.text = str("-")
