extends Node2D

onready var background = get_node("Background")
func _ready():
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
