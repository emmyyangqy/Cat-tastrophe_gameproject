extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_1_pressed():
	if Global.statpoints != 0 and Global.strength < 100:
		Global.statpoints -= 1
		Global.strength += 10
	pass # Replace with function body.


func _on_button_2_pressed():
	if Global.statpoints != 0 and Global.agility < 100:
		Global.statpoints -= 1
		Global.agility += 10
	pass # Replace with function body.


func _on_button_3_pressed():
	if Global.statpoints != 0 and Global.endurance < 100:
		Global.statpoints -= 1
		Global.endurance += 10
	pass # Replace with function body.
