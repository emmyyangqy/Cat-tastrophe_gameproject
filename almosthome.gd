extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	modulate = "ffffff00"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if Global.startcountdown == true:
		modulate = "ffffff"
	pass
