extends Control

const MARK_IN_MAP : String = "H"

var total_health : int = 0
var prob_health : int = 100
var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AnimatedSprite.playing = true
	while true:
		if randi() % 100 < prob_health:
			prob_health -= 10
			total_health += 1
		else:
			break
		if total_health >= $SkelBunny.max_hp - $SkelBunny.hp:
			break
	if $SkelBunny.hp == $SkelBunny.max_hp:
		$Label.text = "You are at full health. You dont need to use the fountain."
	else:
		$Label.text = "Thanks to the fountain you have recovered " + String(total_health) + " health points."
		$SkelBunny.hp += total_health
	
	update_current_level()

#Update the current level variable
func update_current_level():
	var file_of_current_level : File = File.new()
	if not file_of_current_level.file_exists("user://current_level.save"):
		return
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.READ)
	current_level = int(file_of_current_level.get_line())
	file_of_current_level.close()

#continue with the adventure
func _on_Button_pressed():
	#Update the current level file
	var file_of_current_level : File = File.new()
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.WRITE)
	file_of_current_level.store_line(String(current_level + 1))
	file_of_current_level.close()
	#Update the hero status
	#Update the hero status
	var file_of_hero : File = File.new()
# warning-ignore:return_value_discarded
	file_of_hero.open("user://hero.save", File.WRITE)
	file_of_hero.store_line("max_hp " + String($SkelBunny.max_hp))
	file_of_hero.store_line("current_hp " + String($SkelBunny.hp))
	file_of_hero.store_line("max_energy " + String($SkelBunny.max_energy))
	file_of_hero.store_line("money " + String($SkelBunny.money))
	file_of_hero.store_line("shield " + String($SkelBunny.shield))
	file_of_hero.close()
	add_child(MAP.instance())
