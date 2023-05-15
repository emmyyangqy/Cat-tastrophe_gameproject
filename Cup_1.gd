extends CharacterBody2D
#class_name pushableobject

var gravity = 2000


func _physics_process(delta):
	
	velocity.y += gravity
	move_and_slide()
	velocity = Vector2.ZERO
	
func slide(vector):
	velocity.x = vector.x
