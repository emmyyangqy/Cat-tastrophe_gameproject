extends CharacterBody2D


enum State {IDLE, WALK_RIGHT, WALK_LEFT, RUN_RIGHT, RUN_LEFT, JUMP, PAW, SCARED, SLEEP, LAND}
const MOVE_STATES = [State.WALK_RIGHT, State.WALK_LEFT, State.RUN_RIGHT, State.RUN_LEFT]

#const MOVEMENT_VECTORS = {
#	State.WALK_LEFT: [Vector2(1,0)],
#	State.WALK_RIGHT: [Vector2(1,0)],
#	State.RUN_LEFT: [Vector2(1.7,0)],
#	State.RUN_RIGHT: [Vector2(1.7,0)],
#}

var lastvelocity = 0
var curstate = State.IDLE
var state_time = 0 
var death_time = 0
var next = null
var hitnum = 0
var last_velocity = 0
var jump_num = 0
var gravity = 2000
var jump_force = 650
var run_speed = 400
var walk_speed = 150
var jump_done = 0
var isInLight = false
var laststate = State.IDLE
var previousstate = State.IDLE
#var raycast = get_parent().get_node("LightArea/RayCast2D")
var raycast 
var LightArea

var player
var caught = false
	
#
func _ready():
	#var raycast = get_parent().get_node("Camera/LightArea/RayCast2D")
		# Set the "Cast To" property to the position of the player node
	#var player = get_node(".") # Change this to match the path of your player node
	#print(player.global_position)
	#raycast.cast_to = player.global_position #gtehridjosesrgouhifjsdk

	switch_to(State.IDLE)
	
#func _ready() -> void:
#	get_parent().print_tree()
	

func switch_to(new_state: State):
	
#	if curstate == State.death and death_time > 3:
#		new_state = State.revive
	
	
	if curstate == State.JUMP:
		
		if is_on_floor():
#			$cat_animation.play("jump_land")
#			$cat_animation.flip_h = false
			if lastvelocity < 0:
				#$cat_animation.frame = 0
				$cat_animation.play("jump_land")
				$cat_animation.flip_h = true
			elif lastvelocity > 0:
				#$cat_animation.frame = 0
				$cat_animation.play("jump_land")
				$cat_animation.flip_h = false
			else:
				#$cat_animation.frame = 0
				#print("error")
				pass
				#$cat_animation.play("jump_land")
			#wait(1)
			await get_tree().create_timer(.1).timeout
			pass
			
	


		else:
			return
			
	
#
#	if curstate == State.death and death_time > 3:
#		new_state = State.revive
#
		
	curstate = new_state
	state_time = 0.0
	

	if new_state == State.IDLE:
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
		#if is_on_floor() or jump_num < 3:
		if is_on_floor() and jump_num < 1:
			jump_num += 1
			
			$cat_animation.play("jump_beginning")
			if lastvelocity < 0:
				$cat_animation.flip_h = true
				
			elif lastvelocity > 0:
				$cat_animation.flip_h = false
				
			velocity.y = -jump_force
			
#			if last_velocity < 0:
#			#$cat_animation.frame = 0
#				$cat_animation.play("jump_beginning")
#				$cat_animation.flip_h = true
#				velocity.y = -jump_force
#				if Input.is_action_pressed("ui_left"):
#					velocity.x = last_velocity 
#			if last_velocity > 0:
#			#$cat_animation.frame = 0
#				$cat_animation.play("jump_beginning")
#				$cat_animation.flip_h = false
#				velocity.y = -jump_force
#				if Input.is_action_pressed("ui_right"):
#					velocity.x = last_velocity 

#			if is_on_floor():
#				$cat_animation.play("jump_land")
#				$cat_animation.flip_h = false
#				jump_done = 1
		
		else:
			pass
			

			
	elif new_state == State.PAW:
		#$cat_animation.frame = 0
		$cat_animation.play("paw")
	elif new_state == State.SLEEP:
		#$cat_animation.frame = 0
		$cat_animation.play("sleep")
	elif new_state == State.SCARED:
		$cat_animation.play("scared")
	
		
		
#func hit():
#	hitnum += 1
#
#	if hitnum > 3:
#		switch_to(State.dying)
#	else:
#		switch_to(State.hit)


func _physics_process(delta):
	# Update the amount of time you spent in the current state
	state_time += delta
	
	#var player = get_node(".")
	
	
#	var raycast = get_parent().get_node("LightArea/RayCast2D")
#		# Set the "Cast To" property to the position of the player node
#	var player = get_node(".") # Change this to match the path of your player node
#	#print(player.global_position)
#	raycast.target_position = player.global_position #gtehridjosesrgouhifjsdk
	#print(curstate)
	#print(player.global_position)
	


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
		
	if curstate == State.JUMP:
		if Input.is_action_pressed("ui_left"):
			$cat_animation.flip_h = true
			
			if laststate == 1:
				velocity.x = -walk_speed
				#print("kjhghf")
			elif laststate == 3:
				velocity.x = -run_speed
				#print("ghjrebksldaGDSJHK")
			else:
				velocity.x = -walk_speed
#
			
#			if laststate == 3:
#				velocity.x = -run_speed
#			else:
#				velocity.x = -walk_speed
#				#velocity.x = -airjump_speed
				
		if Input.is_action_pressed("ui_right"):
			$cat_animation.flip_h = false
			if laststate == 2:
				velocity.x = walk_speed
			elif laststate == 4:
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

	if is_on_floor():
		jump_num = 0
		jump_done = 0
	
	if velocity.x == 0:
		
		lastvelocity = lastvelocity
	else:
		lastvelocity = velocity.x
		
	if previousstate == curstate:
		previousstate = curstate
		laststate = laststate
	else:
		if curstate != State.JUMP:
			laststate = curstate
			
	raycast = get_parent().get_node("Camera/LightArea/RayCast2D")
	LightArea = get_parent().get_node("Camera/LightArea")
	player = get_node(".")
	
	raycast.target_position = position-LightArea.position
	if raycast.is_colliding():
		if raycast.get_collider().name == "Player":
			caught = true
		else: 
			caught = false
		print(raycast.get_collider().name, ' ', caught)
	
			


	

func _on_animated_sprite_2d_animation_finished():
	
#	if curstate == State.dying:
#		switch_to(State.death)
#		death_time = 0 
		
	if curstate == State.PAW:
		switch_to(State.IDLE)
		
	if curstate == State.JUMP:  #switch to elif
		switch_to(State.IDLE)
		
#	elif curstate == State.revive:
#		switch_to(MOVE_STATES.pick_random())
#		hitnum = 0
	


func _on_light_area_body_entered(body):
	if caught == true:
		get_tree().reload_current_scene()
	#var raycast = get_parent().get_node("LightArea/RayCast2D")
	
	#if body.name == "Area2D":
	#	print("test")
		#var light_shape = body.get_node("CollisionShape2D") as CollisionShape2D
		#var light = body.get_parent().get_node("PointLight2D")
	#var raycast = body.get_node("RayCast2D")
#	var raycast = get_parent().get_node("Camera/LightArea/RayCast2D")
#	var player = get_node(".") # Change this to match the path of your player node
	#print(player.global_position)
	
	
#	if raycast.is_colliding():
#		#pass
#		print(raycast.get_collider().name)
		#print(raycast.global_position, ' ', raycast.target_position, ' ', raycast.position, ' ', player.position)

		
#	if raycast.is_colliding() and raycast.get_collider().name == ".":
#		print("bhjrksnd") # Restart the game or level
#		get_tree().reload_current_scene()	
			
		#if light.is_raycast_enabled():
			#get_tree().reload_current_scene()
			

			
			#if light_shape.test_point(global_transform.origin):
				# Restart the game or level
				#get_tree().reload_current_scene()
			


func _draw():

	#draw_line(Vector2(0,0), raycast.position-player.position, Color.RED)
	
	#draw_line(player.position, player.position+raycast.position, Color.WHITE)
	pass
