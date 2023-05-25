extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.setup_done == true:
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	queue_free()
	pass # Replace with function body.
