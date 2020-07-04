extends AnimatedSprite

var hp : int
var initial_pos : int
var current_pos : int

#This executes at the start of the scene
func _ready():
	randomize()
	hp = int(rand_range(4, 9))
	initial_pos = int(rand_range(5, 10))
	current_pos = initial_pos
	play("Idle")
