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
var jump_force = 1000
var run_speed = 100
var walk_speed = 100
var jump_done = 1


func _ready():
	switch_to(State.IDLE)

func switch_to(new_state: State):
	
#	if curstate == State.death and death_time > 3:
#		new_state = State.revive
	
	
#	if curstate == State.JUMP and new_state != State.JUMP:
#		if jump_done == 1:
#			#jump_done = 0
#			print("hdjfskl")
#			pass
#		else:
#			return
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
		#$cat_animation.frame = 0
		$cat_animation.play("movement_2")
		$cat_animation.flip_h = true
		
	elif new_state == State.JUMP:
		if is_on_floor() or jump_num < 2:
			jump_num += 1
			#$cat_animation.frame = 0
			velocity.y = -jump_force
			$cat_animation.play("jump_beginning")
			$cat_animation.flip_h = false
			if is_on_floor():
				$cat_animation.play("jump_land")
				$cat_animation.flip_h = false
				#jump_done = 1
			
			
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
	
	if is_on_floor():
		jump_num = 0

	if Input.is_action_pressed("walk_left"):
		switch_to(State.WALK_LEFT)
		
	elif Input.is_action_pressed("walk_right"):
		switch_to(State.WALK_RIGHT)
		
	elif Input.is_action_pressed("run_left"):
		switch_to(State.RUN_LEFT)
		
	elif Input.is_action_pressed("run_right"):
		switch_to(State.RUN_RIGHT)
		
	elif Input.is_action_just_pressed("jump"):
		jump_done = 0
		switch_to(State.JUMP)
		
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
		
	print(curstate)
	
	lastvelocity = velocity.x
	#print(velocity.x)

func _on_animated_sprite_2d_animation_finished():
	
#	if curstate == State.dying:
#		switch_to(State.death)
#		death_time = 0 
		
	if curstate == State.PAW:
		switch_to(State.IDLE)
		
	if curstate == State.JUMP:
		switch_to(State.IDLE)
		
#	elif curstate == State.revive:
#		switch_to(MOVE_STATES.pick_random())
#		hitnum = 0
		

