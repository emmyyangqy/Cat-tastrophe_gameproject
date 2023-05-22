extends CharacterBody2D
signal playerinLightArea
signal playeroutLightArea

var rotationSpeed = 2
var addedarearoation_scene1 = .1
var addedarearoation_scene2 = .1
var addedarearoation_scene3 = .9


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if get_parent().name == "Scene_1":
		Global.addedarearoation = -addedarearoation_scene1
		$RayCast2D.rotation = -.03
		
	elif get_parent().name == "Scene_2":
		Global.addedarearoation= addedarearoation_scene2
		$RayCast2D.rotation = -.05
	
	elif get_parent().name == "Scene_3":
		Global.addedarearoation= -addedarearoation_scene3
		$RayCast2D.rotation = -.09
		#$LightArea.rotation = -4
	else: Global.addedarearoation = 0
		
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
