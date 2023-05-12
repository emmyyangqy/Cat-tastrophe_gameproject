extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var raycast = get_node("RayCast2D")
	
	var player = get_node("Cat_character") # change this to match the path of your player node
	raycast.cast_to = player.global_position
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
