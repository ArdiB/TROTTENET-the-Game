extends KinematicBody2D

const GRAVITY = 400
const SPEED = 40
const UP_VECTOR = Vector2(0, -1)

var movement = Vector2(SPEED, 0)

onready var Animation = $AnimatedSprite

func _physics_process(delta):
	movement.y += GRAVITY * delta
	
	if is_on_floor():
		movement. y = 0
	
	if is_on_wall():
		movement.x *= -1
		Animation. flip_h = !Animation. flip_h
		
	move_and_slide_with_snap(movement, Vector2(0, -1), UP_VECTOR)
