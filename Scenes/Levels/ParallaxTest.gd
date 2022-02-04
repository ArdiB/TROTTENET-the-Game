extends Node2D



func _ready():
	pass # Replace with function body.


func _process(delta):
	var cameras = get_tree(). get_nodes_in_group("Camera")
	for camera in cameras:
		$Sprite.position.x = 0.2* camera.position.x
		$Sprite.position.y = 0.2* camera.position.y
	
