extends AnimatedSprite

var energy : int = 1
var hp : int = 5
var max_energy : int = 1

#This executes at the start of the scene
func _ready():
	play("Idle")

#This executes when you die
func death():
	queue_free()

#This executes when you suffer damage
func take_damage(damage : int):
	hp -= damage
	get_parent().get_node("Healt_points-1png/Label").text = String(hp)
	if hp <= 0:
		get_parent().game_over()
		death()
