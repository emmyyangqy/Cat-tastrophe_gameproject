

extends CharacterBody2D


var speed = 200
var speed_air = 200
const jump_speed = -800
var gravity = 2000
var lastvelocity=0
var speed_run = 450
var dbjump = 200

#var score = 0

var lastdir: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	$cat_animation.play("idle_1")


var numjump = 0


func _physics_process(delta):

	var action=0

	#var velocity = Vector2(0,0)


	#print(dir.y)

	# velocity.y += gravity * delta
	#print(numjump)
		# Add the gravity.
	if not is_on_floor():
		#dir.y = -1 
		#print("jks")
		velocity.y += gravity * delta


	if not is_on_floor():
		print("not floor")
		$cat_animation.play("jump")
		$cat_animation.flip_h = false
		if is_on_floor():
			pass

#	if Input.is_action_pressed("jump") and is_on_floor():
#		velocity.y = jump_speed
#		numjump += 1
#		if Input.is_action_pressed("jump") and numjump == 1:
#			velocity.y = jump_speed
#			numjump = 0

	if is_on_floor() and numjump != 0:
		numjump = 0

	if numjump<2:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
			numjump += 1

	if Input.is_action_pressed("move_left"): 
		#dir.x = -speed
		if not is_on_floor():
			velocity.x = -speed_air
		else: 
			if Input.is_action_pressed("shift"):
				velocity.x = -speed_run
			else: 
				velocity.x = -speed
	elif Input.is_action_pressed("move_right"):
		#dir.x = speed
		if not is_on_floor():
			velocity.x = speed_air
		else:
			if Input.is_action_pressed("shift"):
				velocity.x = speed_run
			else: 
				velocity.x = speed

	elif Input.is_action_pressed("paw"):
		action = 2
	elif Input.is_action_pressed("sleep"):
		action = 1

	else:
		#velocity.x = velocity.x * .9
		velocity.x = move_toward(velocity.x, 0, 3000)


	#print(velocity.x)

	if velocity.x != 0:
		if velocity.x > 0:
			if not is_on_floor():
				print("jump")
				$cat_animation.play("jump")
				$cat_animation.flip_h = false
			if Input.is_action_pressed("shift"):
				$cat_animation.play("movement_2")
				$cat_animation.flip_h = false
			else: 
				$cat_animation.play("movement_1")
				$cat_animation.flip_h = false
		elif velocity.x < 0:
			if not is_on_floor():
				$cat_animation.play("jump")
				$cat_animation.flip_h = true
			if Input.is_action_pressed("shift"):
				$cat_animation.play("movement_2")
				$cat_animation.flip_h = true
			else:
				$cat_animation.play("movement_1")
				$cat_animation.flip_h = true

#	elif not is_on_floor():
#			$cat_animation.play("jump")
#			$cat_animation.flip_h = false

	#print(lastvelocity)
	if velocity.x == 0:
		if lastvelocity > 0:
			$cat_animation.play("idle_2")
			$cat_animation.flip_h = false
		elif lastvelocity < 0:
			$cat_animation.play("idle_2")
			$cat_animation.flip_h = true
		elif action == 1:
			#$cat_animation.play("sleep")
			$cat_animation.play("paw")
			$cat_animation.flip_h = false
		elif action == 2:
			#$cat_animation.play("sleep")
			$cat_animation.play("sleep")
			$cat_animation.flip_h = false
		else:
			$cat_animation.play("idle_2")


#		elif not is_on_floor():
#			$cat_animation.play("jump")
#			$cat_animation.flip_h = false


#
	print(velocity.x, " ", lastvelocity)

	#print(is_on_floor())

	move_and_slide()
	lastvelocity = velocity.x
#####################################################

#
#
#extends CharacterBody2D
#
#
#var speed = 350
#var speed_air = 350
#const jump_speed = -800
#var gravity = 2000
#var lastvelocity=0
#var speed_run = 300
#var dbjump = 200
#
##var score = 0
#
#var lastdir: Vector2 = Vector2.ZERO
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	print("ready")
#	$cat_animation.play("idle_1")
#
#
#var numjump = 0
#
#
#func _physics_process(delta):
#
#	var action=0
#
#	#var velocity = Vector2(0,0)
#
#
#	#print(dir.y)
#
#	# velocity.y += gravity * delta
#	#print(numjump)
#		# Add the gravity.
#	if not is_on_floor():
#		#dir.y = -1 
#		#print("jks")
#		velocity.y += gravity * delta
#
#	if is_on_floor() and numjump != 0:
#		numjump = 0
#
#	if numjump<2:
#		if Input.is_action_just_pressed("jump"):
#			velocity.y = jump_speed
#			numjump += 1
#
#	if Input.is_action_pressed("run_left"): 
#		if not is_on_floor():
#			velocity.x = -speed_air
#		else: 
#			if Input.is_action_pressed("shift"):
#				velocity.x = -speed_run
#			else: 
#				velocity.x = -speed
#	elif Input.is_action_pressed("run_right"):
#		#dir.x = speed
#		if not is_on_floor():
#			velocity.x = speed_air
#		else:
#			if Input.is_action_pressed("shift"):
#				velocity.x = speed_run
#			else: 
#				velocity.x = speed
#
#	elif Input.is_action_pressed("sleep"):
#		action = 2
#	elif Input.is_action_pressed("paw"):
#		action = 1
#
#	else:
#		velocity.x = move_toward(velocity.x, 0, 3000)
#
#	if velocity.x != 0:
#		if velocity.x > 0:
#			if not is_on_floor():
#				$cat_animation.play("jump_2")
#				$cat_animation.flip_h = false
#			if Input.is_action_pressed("shift"):
#				$cat_animation.play("movement_2")
#				$cat_animation.flip_h = false
#			else: 
#				$cat_animation.play("movement_1")
#				$cat_animation.flip_h = false
#		elif velocity.x < 0:
#			if not is_on_floor():
#				$cat_animation.play("jump_2")
#				$cat_animation.flip_h = true
#			if Input.is_action_pressed("shift"):
#				$cat_animation.play("movement_2")
#				$cat_animation.flip_h = true
#			else:
#				$cat_animation.play("movement_1")
#				$cat_animation.flip_h = true
#
#
#	if velocity.x == 0:
#		if lastvelocity > 0:
#			$cat_animation.play("idle_2")
#			$cat_animation.flip_h = false
#		elif lastvelocity < 0:
#			$cat_animation.play("idle_2")
#			$cat_animation.flip_h = true
#		elif action == 1:
#			$cat_animation.play("paw")
#			$cat_animation.flip_h = false
#		elif action == 2:
#			$cat_animation.play("sleep")
#			$cat_animation.flip_h = false
#		else:
#			$cat_animation.play("idle_2")
#
##
#	print(velocity.x, " ", lastvelocity)
#
#	move_and_slide()
#	lastvelocity = velocity.x
######################################################
#
