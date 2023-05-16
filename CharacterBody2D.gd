extends CharacterBody2D


#add catnip speed boost, get the cup physics to work

enum State {IDLE, WALK_RIGHT, WALK_LEFT, RUN_RIGHT, RUN_LEFT, JUMP, PAW, SCARED, SLEEP, LAND, CAUGHT}
const MOVE_STATES = [State.WALK_RIGHT, State.WALK_LEFT, State.RUN_RIGHT, State.RUN_LEFT]

#const MOVEMENT_VECTORS = {
#	State.WALK_LEFT: [Vector2(1,0)],
#	State.WALK_RIGHT: [Vector2(1,0)],
#	State.RUN_LEFT: [Vector2(1.7,0)],
#	State.RUN_RIGHT: [Vector2(1.7,0)],
#}

var lastvelocity = 0
var curstate = State.IDLE

var jump_num = 0
var gravity = 2000
var jump_force = 650
var run_speed = 400
var walk_speed = 150
var jump_done = 0
var laststate = State.IDLE
var previousstate = State.IDLE
var state_time = 0
var canpush = false

#var raycast = get_parent().get_node("LightArea/RayCast2D")
var raycast 
var LightArea

var player
var caught = false
var dangerzone = false
var camera
	
#
func _ready():
	switch_to(State.IDLE)
	

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
			

	curstate = new_state


	state_time = 0

	if new_state == State.IDLE:
		$paw_area.monitoring = false
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
		#$cat_animation.frame = 0
		$cat_animation.play("movement_1")
		$cat_animation.flip_h = false

			
	elif new_state == State.WALK_LEFT:
		#$cat_animation.frame = 0
		$cat_animation.play("movement_1")
		$cat_animation.flip_h = true

		
	elif new_state == State.RUN_RIGHT:
		#$cat_animation.frame = 0
		$cat_animation.play("movement_2")
		$cat_animation.flip_h = false
		
	elif new_state == State.RUN_LEFT:
		$cat_animation.play("movement_2")
		$cat_animation.flip_h = true
		
	elif new_state == State.JUMP:
		if is_on_floor() and jump_num < 1:
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
		#$cat_animation.frame = 0
		$cat_animation.play("paw")
		$paw_area.monitoring = true
		#print("paw")
		
	elif new_state == State.SLEEP:
		#$cat_animation.frame = 0
		$cat_animation.play("sleep")
	elif new_state == State.SCARED:
		$cat_animation.play("scared")
		


func _physics_process(delta):

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
				#print("kjhghf")
			elif laststate == 4:
				velocity.x = -run_speed
				#print("ghjrebksldaGDSJHK")
			else:
				velocity.x = -walk_speed

#			if laststate == 3:
#				velocity.x = -run_speed
#			else:
#				velocity.x = -walk_speed
#				#velocity.x = -airjump_speed
				
		if Input.is_action_pressed("ui_right"):
			$cat_animation.flip_h = false
			if laststate == 1:
				velocity.x = walk_speed
			elif laststate == 3:
				velocity.x = run_speed
			else:
				velocity.x = walk_speed
				#velocity.x = airjump_speed
			
			
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
	#print(curstate, ' ', state_time)

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
			
	#Global.state_num = curstate
			
	raycast = get_parent().get_node("Camera/RayCast2D")
	LightArea = get_parent().get_node("Camera/LightArea")
	camera = get_parent().get_node("Camera")
	player = get_node(".")
	
	raycast.target_position = position-LightArea.position-camera.position
	
	if raycast.is_colliding():
		if raycast.get_collider().name == "Player" and dangerzone == true:
			get_tree().reload_current_scene()
		else: 
			pass
			
	state_time += delta
	if state_time > 0.2:
		canpush = true
	else:
		canpush = false
		
	
		
	
	


func _on_animated_sprite_2d_animation_finished():
	
	if curstate == State.PAW:
		switch_to(State.IDLE)
#
	elif curstate == State.JUMP:  #switch to elif
		switch_to(State.IDLE)




func _on_paw_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):

	
	if curstate == State.PAW: # and body != self:

		var struck_toright = false
		var struck_toleft = false
		
		if lastvelocity > 0 and local_shape_index == 1:
			struck_toright = true
		elif lastvelocity < 0 and local_shape_index == 0:
			struck_toleft = true
			
		if struck_toright and body is pushableobjectrigid:
			body.pushright()
			
		if struck_toleft and body is pushableobjectrigid:
			body.pushleft()

		if struck_toright and body is pushableobject:
			body.pushrightkinematic()
			
		if struck_toleft and body is pushableobject:
			body.pushleftkinematic()


func _on_camera_playerin_light_area():
	dangerzone = true
func _on_camera_playerout_light_area():
	dangerzone = false 
