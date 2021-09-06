extends Node2D

onready var background = get_node("Background")
func _ready():
	update_labels()
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _on_Forest_pressed():
	background.frame = 0

func _on_Space_pressed():
	background.frame = 1

func _on_City_pressed():
	background.frame = 2

func _on_InProgress_pressed():
	background.frame = 3


func _on_Menu_pressed():
	TransitionScreen.transition()
	
func _transitioned():
	SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")

func update_labels():
	$VBoxContainer/forest_score_01.text = str("1.    ", $"/root/Highscores".forest_score_01)
	if $"/root/Highscores".forest_score_01 == str (1000):
		$VBoxContainer/forest_score_01.text = str("-")
	$VBoxContainer/forest_score_02.text = str("2.    ", $"/root/Highscores".forest_score_02)
	if $"/root/Highscores".forest_score_02 == str (1000):
		$VBoxContainer/forest_score_02.text = str("-")
	$VBoxContainer/forest_score_03.text = str("3.    ", $"/root/Highscores".forest_score_03)
	if $"/root/Highscores".forest_score_03 == str (1000):
		$VBoxContainer/forest_score_03.text = str("-")
