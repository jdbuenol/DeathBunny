extends Sprite

#This executes at the start of every frame
func _physics_process(_delta):
	scale.x *= 1.01
	scale.y *= 1.01

#Clear timer
func _on_Timer_timeout():
	queue_free()
