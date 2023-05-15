extends pushableobject
#class_name pushableobject

enum State {DEFAULT, BREAK}

var gravity = 2000
var friction = 0.5
var fallingtime = 0
var curstate = State.DEFAULT
#var velocity 

func _ready():
	switch_to(State.DEFAULT)
	
func switch_to(new_state: State):
	curstate = new_state
	
	if new_state == State.DEFAULT:
		$AnimatedSprite2D.play("default")
	elif new_state == State.BREAK:
		$AnimatedSprite2D.play("break")

func _physics_process(delta):
	
	velocity.y += gravity
	
	
	if !is_on_floor():
		pass
	
	
	
	move_and_slide()
	velocity.x = velocity.x* 0.93
	#velocity = Vector2.ZERO
	
	


func pushrightkinematic():
	velocity.x += 100

func pushleftkinematic():
	velocity.x += -100
	
	
