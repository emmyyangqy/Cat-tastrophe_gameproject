extends Area2D

var camera_global_time
const camera_cycle_time = 6.0

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_global_time = 0.0

func _process(delta):
	camera_global_time += delta
	
	var local_time = fmod(camera_global_time, camera_cycle_time)
	var local_animation = local_time / camera_cycle_time

	if local_animation < .5:
		rotation += .002
	else:
		rotation -= .002

