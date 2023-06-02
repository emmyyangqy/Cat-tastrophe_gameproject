extends Area2D


var camera_global_time
var camera_cycle_time = 6.0
var rotationspeed = 1.1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	camera_global_time = 0.0
	
	
		

func _process(delta):
	if Global.isscene_4 == true:
		camera_cycle_time = Global.scene_4_cameratime
		rotationspeed = Global.scene_4_cameraspeed
		
		
	camera_global_time += delta
	
	var local_time = fmod(camera_global_time, camera_cycle_time)
	var local_animation = local_time / camera_cycle_time

	if Global.isscene_4 == true:
		camera_cycle_time = Global.scene_4_cameratime
		rotationspeed = Global.scene_4_cameraspeed
		
		Global.local_animation = local_animation
		
		if local_animation < .5:
			rotation = (local_animation)*rotationspeed+4 + Global.addedarearoation#.55
		else:
			rotation = (-local_animation)*rotationspeed-2.6 + Global.addedarearoation
	else:	
		if local_animation < .5:
			rotation = (local_animation)*rotationspeed+4 + Global.addedarearoation#.55
		else:
			rotation = (-local_animation)*rotationspeed-1.18 + Global.addedarearoation


