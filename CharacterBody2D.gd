extends CharacterBody2D


enum State {IDLE, WALK_RIGHT, WALK_LEFT, RUN_RIGHT, RUN_LEFT, JUMP, PAW, SCARED, SLEEP, LAND}
const MOVE_STATES = [State.WALK_RIGHT, State.WALK_LEFT, State.RUN_RIGHT, State.RUN_LEFT]

#const MOVEMENT_VECTORS = {
#	State.WALK_LEFT: [Vector2(1,0)],
#	State.WALK_RIGHT: [Vector2(1,0)],
#	State.RUN_LEFT: [Vector2(1.7,0)],
#	State.RUN_RIGHT: [Vector2(1.7,0)],
#}

var lastvelocity = null
var curstate = State.IDLE
var state_time = 0 
var death_time = 0
var next = null
var hitnum = 0
var last_velocity = 0
var jump_num = 0
var gravity = 2000
var jump_force = 700
var run_speed = 400
var walk_speed = 150
var jump_done = 0
var isInLight = false

#
func _ready():
	var raycast = get_parent().get_node("LightArea/RayCast2D")
		# Set the "Cast To" property to the position of the player node
	var player = get_node(".") # Change this to match the path of your player node
	raycast.cast_to = player.global_position

	switch_to(State.IDLE)
	
#func _ready() -> void:
#	get_parent().print_tree()
	

func switch_to(new_state: State):
	
#	if curstate == State.death and death_time > 3:
#		new_state = State.revive
	
	
	if curstate == State.JUMP:
		
		if is_on_floor():
			$cat_animation.play("jump_land")
			$cat_animation.flip_h = false
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
		if last_velocity < 0:
			#$cat_animation.frame = 0
			$cat_animation.play("idle_2")
			$cat_animation.flip_h = true
		if last_velocity > 0:
			#$cat_animation.frame = 0
			$cat_animation.play("idle_2")
			$cat_animation.flip_h = false
		else:
			#$cat_animation.frame = 0
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
		if is_on_floor():
			jump_num += 1
			
			$cat_animation.play("jump_beginning")
			$cat_animation.flip_h = true
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
	
	
	#death_time += delta
	
#	if jump_done == 1:
#		switch_to(State.IDLE)
	# velocity.y += gravity * delta
	#print(numjump)
		# Add the gravity.
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if curstate == State.JUMP:
		
		if Input.is_action_pressed("ui_left"):
			$cat_animation.flip_h = true
			velocity.x = last_velocity 
			
			print("jumpingleft")
				
		if Input.is_action_pressed("ui_right"):
			$cat_animation.flip_h = true
			velocity.x = last_velocity 

#	if Input.is_action_pressed("walk_left"):
#		switch_to(State.WALK_LEFT)
#
#	elif Input.is_action_pressed("walk_right"):
#		switch_to(State.WALK_RIGHT)
#
#	elif Input.is_action_pressed("run_left"):
#		switch_to(State.RUN_LEFT)
#
#	elif Input.is_action_pressed("run_right"):
#		switch_to(State.RUN_RIGHT)

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
	
#	if curstate == State.death and death_time > 3:
#		switch_to(State.revive)

	
		#next = move_and_collide(Vector2(-1,0))
		
#	elif not is_on_floor():
#		velocity.y += 100 * delta

		#next = move_and_collide(Vector2(0,10))
		
	else:
		#velocity.x = velocity.x * .9
		switch_to(State.IDLE)
		#velocity.x = move_toward(velocity.x, 0, 3000)

	if curstate == State.WALK_RIGHT:
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
		
	#print(curstate, " ", lastvelocity, " ", jump_num)
	
	if is_on_floor():
		jump_num = 0
		jump_done = 0
	
	if velocity.x == 0:
		lastvelocity = lastvelocity
		
	else:
		lastvelocity = velocity.x
	#print(velocity.x)

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
		

#
#func _on_Player_body_entered(body: Node) -> void:
#	print("ehrjbsdkn")
#	if body.name == "PointLight2D":
#		print("ehrjbsdkn")
#		var light_shape = body.get_node("CollisionShape2D") as CollisionShape2D
#		if light_shape.test_point(global_transform.origin):
#			# Restart the game or level
#			get_tree().reload_current_scene()




func _on_light_area_body_entered(body):
	print("test1")
	if body.name == "Area2D":
		print("test")
		#var light_shape = body.get_node("CollisionShape2D") as CollisionShape2D
		#var light = body.get_parent().get_node("PointLight2D")
		var raycast = body.get_node("RayCast2D")
		if raycast.is_colliding() and raycast.get_collider().name == "CharacterBody2D":
			print("bhjrksnd") # Restart the game or level
			get_tree().reload_current_scene()	
			
		#if light.is_raycast_enabled():
			#get_tree().reload_current_scene()
			


			
			#if light_shape.test_point(global_transform.origin):
				# Restart the game or level
				#get_tree().reload_current_scene()
			
#func _on_Player_body_entered(body: Node) -> void:
#    if body.name == "LightArea":
#        var light = body.get_parent().get_node("Light2D")
#        if light.is_raycast_enabled():
#            # Restart the game or level
#            get_tree().reload_current_scene()

