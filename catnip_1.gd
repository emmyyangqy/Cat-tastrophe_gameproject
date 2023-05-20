class_name catnip extends CharacterBody2D
signal incatnip
signal outcatnip

func _physics_process(delta):
	
	pass


func _on_catnip_entered_body_entered(body):
	if body.name == "Player":
		emit_signal("incatnip")


func _on_catnip_entered_body_exited(body):
	if body.name == "Player":
		emit_signal("outcatnip")
	#pass # Replace with function body.
