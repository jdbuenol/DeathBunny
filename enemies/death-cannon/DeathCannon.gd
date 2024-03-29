extends AnimatedSprite

const DAMAGE : PackedScene = preload("res://enemies/Damage/damage.tscn")

var hp : int
var initial_pos : int
var current_pos : int
var flying : bool = false
var time_left : int
var boss : bool = false

#This executes at the start of the scene
func _ready():
	randomize()
	hp = int(rand_range(4, 9))
	$enemiesHeart/Label.text = String(hp)
	time_left = 3
	$timeLeft.text = String(time_left)
	current_pos = initial_pos

#This executes when hp is zero or lower
func death():
	queue_free()

#This executes when is enemy turn
func make_a_move():
	if time_left == 0:
		get_parent().hurt_skelbunny(1)
		time_left = 3
		$timeLeft.text = String(time_left)
	else:
		time_left -= 1
		$timeLeft.text = String(time_left)

#This executes when the enemy take damage
func take_damage(damage : int):
	hp -= damage
	$enemiesHeart/Label.text = String(hp)
	if damage >= 1:
		var damage_sign : Sprite = DAMAGE.instance()
		get_parent().add_child(damage_sign)
		damage_sign.get_node("Label").text = String(damage)
		damage_sign.global_position = global_position
		damage_sign.global_position.y -= 100

#This executes when the enemy is pushed backwards
func get_pushed(_power : int):
	pass
