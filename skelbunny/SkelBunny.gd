extends AnimatedSprite

var energy : int
var hp : int
var max_hp : int
var max_energy : int
var money : int
var shield : int
var over_energy : int

#This executes at the start of the scene
func _ready():
	over_energy = 0
	var hero : File = File.new()
	if not hero.file_exists("user://hero.save"):
		return
# warning-ignore:return_value_discarded
	hero.open("user://hero.save", File.READ)
	max_hp = int(hero.get_line().split(" ")[1])
	hp = int(hero.get_line().split(" ")[1])
	max_energy = int(hero.get_line().split(" ")[1])
	money = int(hero.get_line().split(" ")[1])
	shield = int(hero.get_line().split(" ")[1])
	energy = max_energy
	hero.close()
	play("Idle")

#This executes when you die
func death():
	queue_free()

#This executes when you suffer damage
func take_damage(damage : int):
	if shield >= damage:
		shield -= damage
		get_parent().get_node("Healt_points-1png/Label2").text = String(shield)
		return
	else:
		damage -= shield
		shield = 0
		get_parent().get_node("Healt_points-1png/Label2").text = String(shield)
	hp -= damage
	get_parent().get_node("Healt_points-1png/Label").text = String(hp) + "/" + String(max_hp)
	if hp <= 0:
		get_parent().game_over()
		death()
