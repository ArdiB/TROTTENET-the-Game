extends "res://Scenes/Saves/PersistentProperties.gd"

var time

var new_score = str(0)

var forest_score_01 = str(1000)
var forest_score_02 = str(1000)
var forest_score_03 = str(1000)

var space_score_01 = str(1000)
var space_score_02 = str(1000)
var space_score_03 = str(1000)

var space_highscore = 0


func _init():
	# override filename
	filepath = 'user://highscores.json'


func update_forest_score():
	if new_score < forest_score_01:
		forest_score_03 = forest_score_02
		forest_score_02 = forest_score_01
		forest_score_01 = new_score
		return
	if new_score < forest_score_02:
		forest_score_03 = forest_score_02
		forest_score_02 = new_score
		return
	if new_score < forest_score_03:
		forest_score_03 = new_score
		return
		
func update_space_score():
	if new_score < space_score_01:
		space_score_03 = space_score_02
		space_score_02 = space_score_01
		space_score_01 = new_score
		return
	if new_score < space_score_02:
		space_score_03 = space_score_02
		space_score_02 = new_score
		return
	if new_score < space_score_03:
		space_score_03 = new_score
		return
