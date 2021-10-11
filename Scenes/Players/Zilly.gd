extends KinematicBody2D


const GRAVITY = 400
const JUMP_POWER = 150
const UP_VECTOR = Vector2(0, -1)

var charactername = "Zilly"
var DECELERATION = 10
var ACCELERATION = 3000
var movement = Vector2() 
var SPEED = 0
var energy = 100
var on_ramp = false
var in_bush = false
var coin_value = 4
var Skill = false


onready var state_machine = $AnimationTree. get("parameters/playback")




func _ready():
	listen_for_ramps()
	listen_for_coins()
	listen_for_slow_items()
	
	
	
func _physics_process(delta):
	movement.x = SPEED
	movement.y += GRAVITY * delta
	# Calculations movement
	
	if in_bush == true and SPEED > 0:
		SPEED -= delta * 100
	
	if SPEED + delta * -DECELERATION > 0:
		SPEED -= delta * DECELERATION
		#Deceleration over time.
	
	if energy < 100:
		energy += 0.1
		#Energy regeneration over time
		
		
	if is_on_wall() == true:
		$Camera2D/CameraShake. _start()
		$"/root/SoundManager".crash()
		energy += 25
		SPEED = 0
		 #Speed reset on wall
		
	
	if Input. is_action_just_pressed("right") and is_on_floor() and (energy >= 25) and state_machine.get_current_node() != "speed_up":
		state_machine.travel("speed_up")
		$"/root/SoundManager".speed_up()
		energy -= 25
		SPEED += delta * ACCELERATION
		#speed up
		
	if Input.is_action_pressed("left") and SPEED > 1:
		SPEED -= 100 * delta
		state_machine.travel("stop")
		#stop
	
	if Input.is_action_pressed("left") and SPEED < 1:
		SPEED = -20
	if !Input.is_action_pressed("left") and SPEED < 0:
		SPEED = 0
		#back
		
	if Input. is_action_just_pressed("jump") and is_on_floor() and state_machine.get_current_node() != "speed_up":
		$"/root/SoundManager".jump()
		movement.y = -JUMP_POWER
		#jump
		
	if Input. is_action_just_pressed("jump") and is_on_floor() and on_ramp == true:
		state_machine.travel("trick")
		$"/root/SoundManager".jump()
		movement.y -= 95 * SPEED * delta
		SPEED += 30 * SPEED * delta 
		#trick
		
	$AnimationTree.set("parameters/conditions/jumping", is_on_floor() == false  and state_machine.get_current_node() != "trick")
	$AnimationTree.set("parameters/conditions/moving", SPEED >= 1 and is_on_floor() and not Input. is_action_pressed("left"))
	$AnimationTree.set("parameters/conditions/not_moving", SPEED < 1 and SPEED >= 0 and is_on_floor())
	$AnimationTree.set("parameters/conditions/back", SPEED < 0 and is_on_floor())
	#animation_conditions
	
	skill_shifter()
	skill()
	check_energy()
	
	energy = clamp(energy, 0, 100)
	coin_value = clamp(coin_value, 0, 4)
	#limitations
	
	movement = move_and_slide_with_snap(movement, Vector2(0, -1), UP_VECTOR)
	
	
	
func skill_shifter():
	if Input.is_action_just_pressed("Skill") and coin_value == 0:
		coin_value += 4
		$GUI/SkillProgress.value = coin_value
		$SkillTimer.start()
		energy += 50
		Skill = true
func _on_SkillTimer_timeout():
	Skill = false
	
func skill():
	if Skill == true:
		SPEED = clamp(SPEED, 0, 200)
		ACCELERATION = 15000
		DECELERATION = 40
	else:
		SPEED = clamp(SPEED, -20, 150)
		ACCELERATION = 3000
		DECELERATION = 10
	if state_machine.get_current_node() == "speed_up" and Skill == true:
		$SkillSprite. visible = true
	else:
		$SkillSprite. visible = false
		
func listen_for_coins():
	var coins = get_tree(). get_nodes_in_group("coin")
	for coin in coins:
		coin.connect("on_collect", self, "on_coin_collected")
		
func on_coin_collected(value):
	coin_value -= value
	$GUI/SkillProgress.value = coin_value
	#update_coin_label()
	
#func update_coin_label():
	#coin_label.text = str ("Coins: ", coin_value)
	
	
func check_energy():
	$"GUI/energy over ".value = energy
	$GUI/Tween. interpolate_property($"GUI/energy under", "value", $"GUI/energy under".value, energy, 0.15,  Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween. start()


func listen_for_ramps():
		var ramps = get_tree(). get_nodes_in_group("ramp")
		for ramp in ramps:
			ramp. connect("on_ramp", self, "ramp_entered")
			ramp. connect("not_on_ramp", self, "ramp_exited")

func ramp_entered():
	on_ramp = true

func ramp_exited():
	on_ramp = false


func listen_for_slow_items():
		var slow_items = get_tree(). get_nodes_in_group("slow_items")
		for slow_item in slow_items:
			slow_item. connect("in_bush", self, "bush_entered")
			slow_item. connect("not_in_bush", self, "bush_exited")

func bush_entered():
	print ("in_bush")
	in_bush = true

func bush_exited():
	in_bush = false



