extends CharacterBody2D


#add catnip speed boost, get the cup physics to work

enum State {IDLE, WALK_RIGHT, WALK_LEFT, RUN_RIGHT, RUN_LEFT, JUMP, PAW, SCARED, SLEEP, LAND, CAUGHT}
const MOVE_STATES = [State.WALK_RIGHT, State.WALK_LEFT, State.RUN_RIGHT, State.RUN_LEFT]

var lastvelocity = 0
var curstate = State.IDLE

var walkenergy = .05 
var runenergy = .2 
var sleepenergy = .1 
var idleenergy = .04
var jumpenergy = 5

var jump_num = 0
var gravity = 2000
var jump_force = 650
var run_speed = 400
var walk_speed = 150

var jump_force_c = 650
var run_speed_c = 400
var walk_speed_c = 150

var jump_done = 0
var laststate = State.IDLE
var previousstate = State.IDLE
var state_time = 0
var canpush = false
var on_doorknob = false
var incatnip = false
#var raycast = get_parent().get_node("LightArea/RayCast2D")
var raycast 
var LightArea
var catnipeffect = false
var catnipeffect_timer = 0

var player
var caught = false
var dangerzone = false
var camera
#var reset_position = Vector2(250,500) 
var reset_position = Vector2(33,518)
var no_energy = false
	
#
func _ready():
	switch_to(State.IDLE)
	if Global.entered_room_2_left == true and Global.entered_room_3_left == true or Global.entered_room_4_left == true:
		print("yes")
		position = Vector2(33,518)
		
		reset_position = Vector2(33,518)
		Global.entered_room_2_left = false
		Global.entered_room_3_left = false
		Global.entered_room_4_left = false
	
		
	if Global.entered_room_1_right == true or Global.entered_room_2_right == true or Global.entered_room_3_right == true:
		position = Vector2(1128,524)
		reset_position = Vector2(1128,524)
		Global.entered_room_1_right=false
		Global.entered_room_2_right=false
#
#	Global.entered_room_3_left == true:
#		osition = Vector2(1128,524)
#		reset_position = Vector2(1128,524)
#		Global.entered_room_3_left=false
	
	
	
	

func switch_to(new_state: State):

	if curstate == State.JUMP:
		if new_state == State.LAND and is_on_floor():
			pass
		else:
			return
			
	if curstate == State.LAND:
		if state_time > .08:
			pass
		else:
			return
			
	if curstate == State.PAW:
		if state_time > .75:
			pass
		else:
			return
			

	if curstate == State.SLEEP and no_energy == true and Global.energy < 90:
		Global.energy += sleepenergy
		return
		
	curstate = new_state


	state_time = 0

	if new_state == State.IDLE:
		$paw_area.monitoring = false
		Global.energy += idleenergy
		#$cat_animation.play("idle_2")
		
		if lastvelocity < 0:
			#$cat_animation.frame = 0
			$cat_animation.play("idle_2")
			$cat_animation.flip_h = true
		elif lastvelocity > 0:
			#$cat_animation.frame = 0
			$cat_animation.play("idle_2")
			$cat_animation.flip_h = false
		else:
			#$cat_animation.frame = 0
			#print("error")
			$cat_animation.play("idle_1")
			
	elif new_state == State.WALK_RIGHT:
		Global.energy -= walkenergy
		#$cat_animation.frame = 0
		$cat_animation.play("movement_1")
		$cat_animation.flip_h = false

			
	elif new_state == State.WALK_LEFT:
		Global.energy -= walkenergy
		#$cat_animation.frame = 0
		$cat_animation.play("movement_1")
		$cat_animation.flip_h = true

		
	elif new_state == State.RUN_RIGHT:
		Global.energy -= runenergy
		#$cat_animation.frame = 0
		$cat_animation.play("movement_2")
		$cat_animation.flip_h = false
		
	elif new_state == State.RUN_LEFT:
		Global.energy -= runenergy
		$cat_animation.play("movement_2")
		$cat_animation.flip_h = true
		
	elif new_state == State.JUMP:
		
		if is_on_floor() and jump_num < 1:
			Global.energy -= jumpenergy
			jump_num += 1
			
			$cat_animation.play("jump_beginning")
			if lastvelocity < 0:
				$cat_animation.flip_h = true
				
			elif lastvelocity > 0:
				$cat_animation.flip_h = false
				
			velocity.y = -jump_force
		
		else:
			pass
			
			
	elif new_state == State.LAND:
		$cat_animation.play("jump_land")

	elif new_state == State.PAW:
		$cat_animation.play("paw")
		$paw_area.monitoring = true
		#print("paw")
		
	elif new_state == State.SLEEP:
		$cat_animation.play("sleep")
		Global.energy += sleepenergy
		
	elif new_state == State.SCARED:
		$cat_animation.play("scared")
		



func _physics_process(delta):
	
	#print(position)
	
	if catnipeffect == false:
		run_speed = 400 + (Global.agility-10)*10
		walk_speed = 150 + (Global.agility-10)*4
		
		walkenergy = .05 - .05*((Global.endurance-10)/90)
		runenergy = .2 - .05*((Global.endurance-10)/90)
		jumpenergy = 5 - 5*((Global.endurance-10)/90)

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump"):
		jump_done = 0
		switch_to(State.JUMP)

	elif Input.is_action_pressed("walk_left"):
		if Input.is_action_pressed("shift"):
			switch_to(State.RUN_LEFT)
		else: switch_to(State.WALK_LEFT)
		
	elif Input.is_action_pressed("walk_right"):
		if Input.is_action_pressed("shift"):
			switch_to(State.RUN_RIGHT)
		else: switch_to(State.WALK_RIGHT)
		
	elif Input.is_action_pressed("paw"):
		switch_to(State.PAW)
		
	elif Input.is_action_pressed("sleep"):
		switch_to(State.SLEEP)
	
	else:
		switch_to(State.IDLE)
		
	if curstate == State.JUMP and state_time > 0.1:
		switch_to(State.LAND)
		
	if curstate == State.JUMP:
		if Input.is_action_pressed("ui_left"):
			$cat_animation.flip_h = true
			
			if laststate == 2:
				velocity.x = -walk_speed
			elif laststate == 4:
				velocity.x = -run_speed
			else:
				velocity.x = -walk_speed

				
		if Input.is_action_pressed("ui_right"):
			$cat_animation.flip_h = false
			if laststate == 1:
				velocity.x = walk_speed
			elif laststate == 3:
				velocity.x = run_speed
			else:
				velocity.x = walk_speed
			
			
	elif curstate == State.WALK_RIGHT:
		velocity.x = walk_speed
	elif curstate == State.WALK_LEFT:
		velocity.x = -walk_speed
	elif curstate == State.RUN_RIGHT:
		velocity.x = run_speed
	elif curstate == State.RUN_LEFT:
		velocity.x = -run_speed
	else:
		velocity.x = 0
		
	move_and_slide()

	if is_on_floor():
		jump_num = 0
		jump_done = 0
	
	if velocity.x == 0:
		lastvelocity = lastvelocity
	else:
		lastvelocity = velocity.x
		
	if previousstate == curstate:
		#state_time=0
		previousstate = curstate
		laststate = laststate
	else:
		if curstate != State.JUMP:
			
			laststate = curstate



func _on_cat_animation_animation_finished():
	if curstate == State.PAW:
		switch_to(State.IDLE)
#
	elif curstate == State.JUMP:  #switch to elif
		switch_to(State.IDLE)
