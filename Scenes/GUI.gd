extends CanvasLayer

#onready var player_vars = get_node("/root/player")

func _ready():
	pass # Replace with function body.

#func _physics_process(delta):
	#$"MarginContainer/VBoxContainer/Energy Bar". value = player_vars.energy
	


func _on_TextureButton_pressed():
	get_tree(). reload_current_scene()
