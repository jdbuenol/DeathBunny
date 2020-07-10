extends AnimatedSprite

const DAMAGE : PackedScene = preload("res://enemies/Damage/damage.tscn")

var hp : int
var initial_pos : int
var current_pos : int
var flying : bool = false
var moving : bool = false
var desire_pos : float = 0

#This executes at the start of the scene
func _ready():
	randomize()
	hp = int(rand_range(2, 5))
	$enemiesHeart/Label.text = String(hp)
	current_pos = initial_pos
	desire_pos = 77.352 + 110 * (current_pos - 1)

#This executes every frame
func _physics_process(_delta):
	if moving:
		position.x -= 3
		if position.x <= desire_pos:
			moving = false

#This executes when hp is zero or lower
func death():
	queue_free()

#This executes when is enemy turn
func make_a_move():
	if current_pos == 2:
		get_parent().hurt_skelbunny(1)
		current_pos = 9
		get_parent().reposition_enemy(self)
		desire_pos = 77.352 + 110 * (current_pos - 1)
	elif current_pos == 3:
		current_pos -= 1
		desire_pos -= 110
		moving = true
	else:
		current_pos -= 2
		desire_pos -= 220
		moving = true

#This executes when the enemy take damage
func take_damage(damage : int):
	hp -= damage
	$enemiesHeart/Label.text = String(hp)
	var damage_sign : Sprite = DAMAGE.instance()
	add_child(damage_sign)
	damage_sign.get_node("Label").text = String(damage)
	damage_sign.global_position.y -= 100