extends CharacterBody2D
signal playerinLightArea
signal playeroutLightArea

var rotationSpeed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if get_parent().name == "Scene_3":
		print("3333333")
		$LightArea.rotation = -9.5
		$RayCast2D.rotation = -.09
		#$LightArea.rotation = -4
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Camera.rotate(rotationSpeed)
	pass




func _on_light_area_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("playerinLightArea")


func _on_light_area_body_exited(body):
	if body.get_name() == "Player":
		emit_signal("playeroutLightArea")
