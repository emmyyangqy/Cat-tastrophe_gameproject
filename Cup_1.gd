extends pushableobject

enum State {DEFAULT, BREAK, BROKEN, ALRBROKE}

var gravity = 100
var friction = 0.5
var fallingtime = 0
var curstate = State.DEFAULT


func _ready():
	switch_to(State.DEFAULT)
	
	if Global.cupbroken_1 == true and get_node(".").name == "Cup_1":
			position = Global.cupposition_1
			switch_to(State.ALRBROKE)

	if Global.cupbroken_2 == true and get_node(".").name == "Cup_2":
			position = Global.cupposition_2
			switch_to(State.ALRBROKE)
			
	if Global.cupbroken_3 == true and get_node(".").name == "Cup_3":
			position = Global.cupposition_3
			switch_to(State.ALRBROKE)
	if Global.cupbroken_4 == true and get_node(".").name == "Cup_4":
			position = Global.cupposition_4
			switch_to(State.ALRBROKE)

		
	
func switch_to(new_state: State):
	curstate = new_state
	
	if new_state == State.DEFAULT:
		$AnimatedSprite2D.play("default")
	elif new_state == State.BREAK:
		$AnimatedSprite2D.play("break")
		
	elif new_state == State.BROKEN:
		$AnimatedSprite2D.play("broken")
		$CollisionPolygon2D.queue_free()
		
		if get_node(".").name == "Cup_1":
			Global.cupbroken_1 = true
			Global.cupposition_1 = position
			
		if get_node(".").name == "Cup_2":
			Global.cupbroken_2 = true
			Global.cupposition_2 = position
			
		if get_node(".").name == "Cup_3":
			Global.cupbroken_3 = true
			Global.cupposition_3 = position
		
		if get_node(".").name == "Cup_4":
			Global.cupbroken_4 = true
			Global.cupposition_4 = position
			
	elif new_state == State.ALRBROKE:
		$AnimatedSprite2D.play("broken")
		$CollisionPolygon2D.queue_free()

func _physics_process(delta):
	
	if !is_on_floor() and curstate != State.BROKEN and curstate != State. ALRBROKE:
		velocity.y += gravity
	
	if !is_on_floor():
		fallingtime += delta
		
	if fallingtime > 0.2 and is_on_floor():
		velocity.x = velocity.x* 0.5
		switch_to(State.BREAK)
		fallingtime = 0
	
	if is_on_floor() and fallingtime < 0.2:
		fallingtime = 0
	
	move_and_slide()
	velocity.x = velocity.x* 0.93
	

func pushrightkinematic():
	velocity.x += 80

func pushleftkinematic():
	velocity.x += -80

func _on_animated_sprite_2d_animation_finished():
	if curstate == State.BREAK:
		Global.score += 1
		switch_to(State.BROKEN)
