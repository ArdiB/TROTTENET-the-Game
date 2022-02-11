extends KinematicBody2D



const GRAVITY = 400
const JUMP_POWER = 150
const UP_VECTOR = Vector2(0, -1)

export var charactername = "Charactername"
export var ENG_points = 0
export var STR_points = 0
export var SPE_points = 0

var ENG = 0.05 + ENG_points*0.05
var STR = 2500 + STR_points*250
var SPE = 150 + SPE_points*25
var SPEED = 0
var DECELERATION = 10
var movement = Vector2() 
var energy = 100
var on_ramp = false
var on_boost = false
var in_bush = false
var skill = false
var skill_progress = 4
var direction_switch = false
var in_direction_switch = false

onready var state_machine = $AnimationTree. get("parameters/playback")



func _ready():
	ENG = 0.05 + ENG_points*0.05
	STR = 2500 + STR_points*250
	SPE = 150 + SPE_points*25 
	$"/root/TransitionScreen".connect("transitioned", self, ("_transitioned"))
	connect_coins()



func _physics_process(delta):
	#Functions
	skill_shifter()
	skill()
	check_energy()
	if direction_switch == false:
		movement(delta)
	if direction_switch == true:
		movement_switched(delta)


	# Calculations movement
	movement.x = SPEED
	movement.y += GRAVITY * delta
	movement = move_and_slide_with_snap(movement, Vector2(0, -1), UP_VECTOR)


	#Energy regeneration over time.
	if energy < 100:
		energy += ENG


	#Interactions with Items
	if on_boost == true:
		SPEED += delta * 800
	if in_bush == true and SPEED > 0:
		SPEED -= delta * 80


	#Crash
	if is_on_wall() == true:
		$CharacterCamera/CameraShake. _start()
		$"/root/SoundManager".crash()
		energy += 25
		SPEED = 0



#Player Movement
func movement(delta):
	#limitations
	skill_progress = clamp(skill_progress, 0, 4)
	SPEED = clamp(SPEED, -20, SPE)


	#Deceleration over time.
	if SPEED - delta * DECELERATION > 0:
		SPEED -= delta * DECELERATION


	#Action Inputs
	if Input. is_action_just_pressed("right") and is_on_floor() and (energy >= 25) and state_machine.get_current_node() != "speed_up":
		state_machine.travel("speed_up")
		$"/root/SoundManager".speed_up()
		energy -= 25
		SPEED += delta * STR
		dust()

	if Input.is_action_pressed("left") and SPEED > 1:
		SPEED -= 100 * delta
		state_machine.travel("stop")
	if Input.is_action_pressed("left") and SPEED < 1:
		SPEED = -20
	if !Input.is_action_pressed("left") and SPEED < 0:
		SPEED = 0

	if Input. is_action_just_pressed("jump") and is_on_floor():
		 #and state_machine.get_current_node() != "speed_up":
		$"/root/SoundManager".jump()
		movement.y = -JUMP_POWER

	if Input. is_action_just_pressed("jump") and is_on_floor() and on_ramp == true:
		state_machine.travel("trick")
		movement.y -= 95 * SPEED * delta
		SPEED += 30 * SPEED * delta 


	#Animation_conditions
	$AnimationTree.set("parameters/conditions/jumping", is_on_floor() == false  and state_machine.get_current_node() != "trick")
	$AnimationTree.set("parameters/conditions/moving", SPEED >= 1 and is_on_floor() and not Input. is_action_pressed("left"))
	$AnimationTree.set("parameters/conditions/not_moving", SPEED < 1 and SPEED >= 0 and is_on_floor())
	$AnimationTree.set("parameters/conditions/back", SPEED < 0 and is_on_floor())

func movement_switched(delta):
	#limitations
	skill_progress = clamp(skill_progress, 0, 4)
	SPEED = clamp(SPEED, -SPE, 20)


	#Deceleration over time.
	if SPEED + delta * DECELERATION < 0:
		SPEED += delta * DECELERATION


	#Action Inputs
	if Input. is_action_just_pressed("right") and is_on_floor() and (energy >= 25) and state_machine.get_current_node() != "speed_up":
		state_machine.travel("speed_up")
		$"/root/SoundManager".speed_up()
		energy -= 25
		SPEED -= delta * STR
		dust()

	if Input.is_action_pressed("left") and SPEED < -1:
		SPEED += 100 * delta
		state_machine.travel("stop")
	if Input.is_action_pressed("left") and SPEED > -1:
		SPEED = 20
	if !Input.is_action_pressed("left") and SPEED > 0:
		SPEED = 0

	if Input. is_action_just_pressed("jump") and is_on_floor():
		 #and state_machine.get_current_node() != "speed_up":
		$"/root/SoundManager".jump()
		movement.y = -JUMP_POWER

	if Input. is_action_just_pressed("jump") and is_on_floor() and on_ramp == true:
		state_machine.travel("trick")
		movement.y += 95 * SPEED * delta
		SPEED += 30 * SPEED * delta 


	#Animation_conditions
	$AnimationTree.set("parameters/conditions/jumping", is_on_floor() == false  and state_machine.get_current_node() != "trick")
	$AnimationTree.set("parameters/conditions/moving", SPEED <= -1 and is_on_floor() and not Input. is_action_pressed("left"))
	$AnimationTree.set("parameters/conditions/not_moving", SPEED > -1 and SPEED <= 0 and is_on_floor())
	$AnimationTree.set("parameters/conditions/back", SPEED > 0 and is_on_floor())



#Skill
func skill_shifter():
	if Input.is_action_just_pressed("Skill") and skill_progress == 0:
		skill_progress += 4
		$GUI/SkillProgress.value = skill_progress
		$SkillTimer.start()
		skill = true

func _on_SkillTimer_timeout():
	skill = false
	energy += 100
	$GUI/SkillSprite.visible = false

func skill():
	if skill == true:
		$GUI/SkillSprite.visible = true
		energy = clamp(energy, 0, 100000)
		energy = 100000
	else:
		energy = clamp(energy, 0, 100)



#Coins
func connect_coins():
	var coins = get_tree(). get_nodes_in_group("coin")
	for coin in coins:
		coin.connect("on_collect", self, "on_coin_collected")

func on_coin_collected(value):
	skill_progress -= value
	$GUI/SkillProgress.value = skill_progress
	#update_coin_label()



#Energy
func check_energy():
	$"GUI/energy over ".value = energy
	$GUI/Tween. interpolate_property($"GUI/energy under", "value", $"GUI/energy under".value, energy, 0.15,  Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween. start()



#Interaction with Areas
func _on_Area2D_area_entered(area):
	if area.name.begins_with("Direction"):
		in_direction_switch = true
		TransitionScreen.transition()
	if area.name.begins_with("Bush"):
		in_bush = true
	if area.name.begins_with("Portal"):
		$CharacterCamera.zoom.y = -$CharacterCamera.zoom.y
	if area.name.begins_with("Ramp"):
		on_ramp = true
	if area.name.begins_with("Speed"):
		on_boost  = true
		$"/root/SoundManager". speed_boost()

func _on_Area2D_area_exited(area):
	if area.name.begins_with("Direction"):
		in_direction_switch = false
	if area.name.begins_with("Bush"):
		in_bush = false
	if area.name.begins_with("Ramp"):
		on_ramp = false
	if area.name.begins_with("Speed"):
		on_boost  = false



#DirectionSwitch
func _transitioned():
	if in_direction_switch == true:
		direction_switch = !direction_switch 
		SPEED *= -1
		self.scale.x *= -1
	


#Ghost
func _on_ghost_timer_timeout():
	#if state_machine.get_current_node() == "speed_up":
	if on_boost == true and SPEED > 0:
		# first make a copy of the ghost object
		var this_ghost = preload ("res://Scenes/Ghost.tscn").instance();
		# give the ghost a parent
		get_parent(). add_child(this_ghost);
		get_parent(). move_child(this_ghost, 5);
		this_ghost.position = global_position + $Sprite.position
		this_ghost.texture = $Sprite.texture
		this_ghost.vframes = $Sprite.vframes
		this_ghost.hframes = $Sprite.hframes
		this_ghost.frame = $Sprite.frame



#Dust
func dust():
	$Sprite/Dust.playing = true
func _on_Dust_animation_finished():
	$Sprite/Dust.playing = false
