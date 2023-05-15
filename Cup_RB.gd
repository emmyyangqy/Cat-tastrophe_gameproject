extends pushableobject

enum State {DEFAULT, BREAK}

var gravity = 2000
var curstate = State.DEFAULT
var contact = true
var fallingtime = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	switch_to(State.DEFAULT)

	pass # Replace with function body.

func switch_to(new_state: State):
	curstate = new_state
	
	if new_state == State.DEFAULT:
		$AnimatedSprite2D.play("default")
	elif new_state == State.BREAK:
		$AnimatedSprite2D.play("break")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	

	if contact == false:
		fallingtime += delta
		if fallingtime > .2 and contact == true:
			switch_to(State.BREAK)
			
	elif contact == true:
		fallingtime = 0
	
	print(curstate, ' ', fallingtime)

	
func pushright():
	apply_central_impulse(Vector2(200,0))

func pushleft():
	apply_central_impulse(Vector2(-200,0))
	
	


func _on_aroundcuparea_body_entered(body):
	if body.get_name() != "Player":
		contact = true
	#pass # Replace with function body.
	
	


func _on_aroundcuparea_body_exited(body):
	contact = false
	#pass # Replace with function body.
