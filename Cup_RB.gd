extends pushableobject

var gravity = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
	
func pushright():
	apply_central_impulse(Vector2(200,0))

func pushleft():
	apply_central_impulse(Vector2(-200,0))

