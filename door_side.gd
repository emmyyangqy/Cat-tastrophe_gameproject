extends doorknob

enum State {CLOSE, OPEN}
var curstate = State.CLOSE
signal on_doorknob
signal off_doorknob

func _ready():
	switch_to(State.CLOSE)

	if get_parent().name == "Scene_1" and Global.dooropen_1 == true:
		switch_to(State.OPEN)
	if get_parent().name == "Scene_2" and Global.dooropen_2 == true:
		switch_to(State.OPEN)
	
func switch_to(new_state: State):
	curstate = new_state
	
	
	if new_state == State.CLOSE:
		$AnimatedSprite2D.play("closed")
	elif new_state == State.OPEN:
		$AnimatedSprite2D.play("open")
		$doorshape.queue_free()
		$doorknob2.queue_free()
		
		if get_parent().name == "Scene_2":
			Global.dooropen_2 = true
	
func _physics_process(delta):
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

