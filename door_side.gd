extends doorknob

enum State {CLOSE, OPEN}
var curstate = State.CLOSE
signal on_doorknob
signal off_doorknob

func _ready():
	print("ready")
	switch_to(State.CLOSE)
	print(get_parent().name)
	if get_parent().name == "Scene_1" and Global.dooropen_1 == true:
		switch_to(State.OPEN)
	
func switch_to(new_state: State):
	curstate = new_state
	
	
	if new_state == State.CLOSE:
		$AnimatedSprite2D.play("closed")
	elif new_state == State.OPEN:
		$AnimatedSprite2D.play("open")
		$doorshape.queue_free()
		$doorknob2.queue_free()

func _physics_process(delta):
	# Add the gravity.
	pass

func opendoor():
	switch_to(State.OPEN)


func _on_doorknob_body_entered(body):
	if body.get_name() == "Player":
		print("doorknob")
		emit_signal("on_doorknob")

func _on_doorknob_body_exited(body):
	if body.get_name() == "Player":
		emit_signal("off_doorknob")

