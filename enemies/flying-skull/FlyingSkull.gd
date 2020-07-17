extends AnimatedSprite

const DAMAGE : PackedScene = preload("res://enemies/Damage/damage.tscn")

var hp : int
var initial_pos : int
var current_pos : int
var flying : bool = true
var moving : bool = false
var moving_backwards : bool = false
var desire_pos : float = 0
var boss : bool = false
var push_power : int = 0

#This executes at the start of the scene
func _ready():
	randomize()
	hp = int(rand_range(8, 18))
	$enemiesHeart/Label.text = String(hp)
	current_pos = initial_pos
	desire_pos = 77.352 + 110 * (current_pos - 1)

#This executes every frame
func _physics_process(_delta):
	if moving:
		position.x -= 1.5
		if position.x <= desire_pos:
			moving = false
	elif moving_backwards:
		position.x += push_power
		if position.x >= desire_pos:
			moving_backwards = false

#This executes when hp is zero or lower
func death():
	queue_free()

#This executes when is enemy turn
func make_a_move():
	if current_pos == 2:
		get_parent().hurt_skelbunny(2)
		current_pos = 9
		get_parent().reposition_enemy(self)
		desire_pos = 77.352 + 110 * (current_pos - 1)
	else:
		current_pos -= 1
		desire_pos -= 110
		moving = true

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
func get_pushed(power : int):
	push_power = power * 3
	if current_pos < 9:
		current_pos += power
		if current_pos > 9:
			current_pos = 9
		desire_pos = 77.352 + 110 * (current_pos - 1)
		moving_backwards = true
