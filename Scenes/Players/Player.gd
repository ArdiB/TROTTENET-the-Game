extends KinematicBody2D


const GRAVITY = 400
const JUMP_POWER = 150
const UP_VECTOR = Vector2(0, -1)
const ACCELERATION = 3000
const DECELERATION = 10

var movement = Vector2() 
var SPEED = 0
var energy = 100
var on_ramp = false
var coin_value = 4

onready var state_machine = $AnimationTree. get("parameters/playback")

func _ready():
	listen_for_coins()
	
func _physics_process(delta):
	
	
	if SPEED + delta * -DECELERATION > 0:
		SPEED -= delta * DECELERATION
		#Deceleration over time.
	
	if energy < 100:
		energy += 0.1
		#Energy regeneration over time
		
	if is_on_wall() == true:
		SPEED = 0
		 #Speed reset on wall
		
	#print (SPEED)
	
	movement.x = SPEED
	movement.y += GRAVITY * delta
	# Calculations movement
	
	if Input. is_action_just_pressed("right") and is_on_floor() and (energy >= 25) and state_machine.get_current_node() != "speed_up":
		state_machine.travel("speed_up")
		energy -= 25
		SPEED += delta * ACCELERATION
		#speed up
		
	if Input.is_action_pressed("left") and SPEED > 0:
		SPEED -= 100 * delta
		state_machine.travel("drag")
		#drag
		
	if Input. is_action_just_pressed("jump") and is_on_floor() and state_machine.get_current_node() != "speed_up":
		movement.y = -JUMP_POWER
		
	if Input. is_action_just_pressed("jump") and is_on_floor() and on_ramp == true:
		state_machine.travel("trick")
		SPEED += 10000000 * delta 
		movement.y -= 12000 * delta
		
	$AnimationTree.set("parameters/conditions/jumping", not is_on_floor() and state_machine.get_current_node() != "trick")
	$AnimationTree.set("parameters/conditions/moving", abs(movement.x) > 1 and is_on_floor() and not Input.is_action_pressed("left"))
	$AnimationTree.set("parameters/conditions/not_moving", abs(movement.x) < 1 and is_on_floor())
	
	
	check_energy()
	
	SPEED = clamp(SPEED, 0, 150)
	energy = clamp(energy, 0, 100)
	coin_value = clamp(coin_value, 0, 4)
	#limitations
	
	movement = move_and_slide(movement, UP_VECTOR)
	
	
func listen_for_coins():
	var coins = get_tree(). get_nodes_in_group("coin")
	for coin in coins:
		coin.connect("on_collect", self, "on_coin_collected")
		
func on_coin_collected(value):
	coin_value -= value
	
	#update_coin_label()
	
#func update_coin_label():
	#coin_label.text = str ("Coins: ", coin_value)
	
func check_energy():
	$"GUI/MarginContainer/energy over ".value = energy
	$GUI/MarginContainer/Tween. interpolate_property($"GUI/MarginContainer/energy under", "value", $"GUI/MarginContainer/energy under".value, energy, 0.15,  Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/MarginContainer/Tween. start()

func _on_Ramp_body_entered(body):
	on_ramp = true
	#print(on_ramp)


func _on_Ramp_body_exited(body):
	on_ramp = false
	#print(on_ramp)
