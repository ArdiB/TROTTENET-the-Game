extends CanvasLayer

onready var background = get_node("Background")
func _ready():
	update_labels()
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))

func _on_Forest_pressed():
	background.frame = 0
	$ForestScores.visible = true
	$SpaceScores.visible = false
	$CityScores.visible =  false
func _on_Space_pressed():
	background.frame = 1
	$ForestScores.visible = false
	$SpaceScores.visible = true
	$CityScores.visible =  false
func _on_City_pressed():
	background.frame = 2
	$ForestScores.visible = false
	$SpaceScores.visible = false
	$CityScores.visible =  true


func _on_Close_pressed():
	if get_parent().name.begins_with("Selection"):
		get_tree().paused = false
		self. queue_free()
	if get_parent().name.begins_with("Level"):
		TransitionScreen.transition()

func _transitioned():
	get_tree().paused = false
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
		
	#city_level_labels
	$CityScores/CityScore01.text = str("1.    ", $"/root/Highscores".city_score_01)
	if $"/root/Highscores".city_score_01 == str (1000):
		$CityScores/CityScore01.text = str("-")
	$CityScores/CityScore02.text = str("2.    ", $"/root/Highscores".city_score_02)
	if $"/root/Highscores".city_score_02 == str (1000):
		$CityScores/CityScore02.text = str("-")
	$CityScores/CityScore03.text = str("3.    ", $"/root/Highscores".city_score_03)
	if $"/root/Highscores".city_score_03 == str (1000):
		$CityScores/CityScore03.text = str("-")


