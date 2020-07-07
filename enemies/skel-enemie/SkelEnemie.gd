extends AnimatedSprite

var hp : int
var initial_pos : int
var current_pos : int
var flying : bool = false

#This executes at the start of the scene
func _ready():
	randomize()
	hp = int(rand_range(4, 9))
	current_pos = initial_pos
	play("Idle")

#This executes when hp is zero or lower
func death():
	queue_free()

#This executes when is enemy turn
func make_a_move():
	if current_pos == 2:
		get_parent().hurt_skelbunny(2)
		current_pos = 9
	else:
		current_pos -= 1
	get_parent().reposition_enemy(self)
