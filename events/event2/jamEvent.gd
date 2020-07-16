extends Control

const MARK_IN_MAP : String = "V"
var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")

var label_text : String = "You have found a curious event called a \"Jam.\" you decided to participate and have a fun time. Your max energy has been increased by 1."
var n : int = 0

#This executes at the start of the scene
func _ready():
	$Button.visible = false
	update_current_level()
	$Timer.start()
	$SkelBunny.max_energy += 1
	$SkelBunny.energy += 1

#Update the current level variable
func update_current_level():
	var file_of_current_level : File = File.new()
	if not file_of_current_level.file_exists("user://current_level.save"):
		return
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.READ)
	current_level = int(file_of_current_level.get_line())
	file_of_current_level.close()

#Text delay
func _on_Timer_timeout():
	if n > label_text.length():
		$Button.visible = true
	else:
		n += 1
		$Label.text = label_text.substr(0, n)
		$Timer.start()

#Continue with the adventure
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
