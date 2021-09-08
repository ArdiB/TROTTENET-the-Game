extends KinematicBody2D


var SPEED = -40


var movement = Vector2(SPEED, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if is_on_wall():
		$Explosion.visible = true
		$Explosion.playing = true
		$Rotation.visible = false
	
	move_and_slide(movement, Vector2(0, 0))


func _on_Explosion_animation_finished():
	self. queue_free()
