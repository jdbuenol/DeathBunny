extends AnimatedSprite

var energy : int = 1
var hp : int = 5
var max_energy : int = 1

#This executes at the start of the scene
func _ready():
	play("Idle")

func death():
	queue_free()
