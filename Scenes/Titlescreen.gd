extends Control


func _ready():
	pass


func _process(delta):
	_continue()
	
	
func _continue():
	if Input. is_action_just_pressed("ACCEPT"):
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
		#get_tree(). change_scene("res://Scenes/TestLevel.tscn")
