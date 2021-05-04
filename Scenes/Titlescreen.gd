extends Control


func _ready():
	$TweenLogo.interpolate_property($Logo, "position", Vector2(160, -120), Vector2(160, 110), 2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$TweenLogo.start()
func _process(delta):
	_continue()
	
	
func _continue():
	if Input. is_action_just_pressed("ACCEPT"):
		SceneLoader.goto_scene("res://Scenes/SelectionMenu.tscn")
		#get_tree(). change_scene("res://Scenes/TestLevel.tscn")


func _on_TweenLogo_tween_all_completed():
	$Titlescreen/PressEnter.visible = true
