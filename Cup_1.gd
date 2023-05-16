extends pushableobject
#class_name pushableobject

enum State {DEFAULT, BREAK, BROKEN}

var gravity = 100
var friction = 0.5
var fallingtime = 0
var curstate = State.DEFAULT
var score = $Global
#var velocity 

func _ready():
	switch_to(State.DEFAULT)
	
func switch_to(new_state: State):
	curstate = new_state
	
	if new_state == State.DEFAULT:
		$AnimatedSprite2D.play("default")
	elif new_state == State.BREAK:
		$AnimatedSprite2D.play("break")
		
	elif new_state == State.BROKEN:
		$AnimatedSprite2D.play("broken")
		$CollisionShape2D.queue_free()

func _physics_process(delta):
	
	if !is_on_floor() and curstate != State.BROKEN:
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
	#velocity = Vector2.ZERO
	

func pushrightkinematic():
	velocity.x += 100

func pushleftkinematic():
	velocity.x += -100
	
	


func _on_animated_sprite_2d_animation_finished():
	if curstate == State.BREAK:
		score += 1
		switch_to(State.BROKEN)
