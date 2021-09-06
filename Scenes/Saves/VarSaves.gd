extends "res://Scenes/Saves/PersistentProperties.gd"


var character: int = 0
var level: int = 0
var fullscreen: bool = false


func _init():
	# override filename
	filepath = 'user://save_game.json'
