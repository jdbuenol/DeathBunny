extends Control

const MARK_IN_MAP : String = "V"
var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")

var label_text : String = "In front of you there are 3 vases, one contains a curse, other contains endless richness and the last one contains nothingness."
var n : int = 0

#This executes at the start of the scene
func _ready():
	update_current_level()
	for x in range(1, 5):
		get_node("Button" + String(x)).visible = false
	$Timer.start()

#Delay of text
func _on_Timer_timeout():
	if n > label_text.length():
		show_options()
	else:
		n += 1
		$Timer.start()
		$Label.text = label_text.substr(0, n)

#Update the current level variable
func update_current_level():
	var file_of_current_level : File = File.new()
	if not file_of_current_level.file_exists("user://current_level.save"):
		return
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.READ)
	current_level = int(file_of_current_level.get_line())
	file_of_current_level.close()

#Show the three options
func show_options():
	for x in range(1, 4):
		get_node("Button" + String(x)).visible = true

#Buttons input
func _on_Button1_pressed():
	for x in range(1, 4):
		get_node("Button" + String(x)).queue_free()
	randomize()
	if randf() < (1.0/3.0):
		bad_choice()
	elif randf() < (2.0/3.0):
		nothing_choice()
	else:
		good_choice()

#bad choice
func bad_choice():
	n = 0
	if $SkelBunny.money > 100:
		label_text = "You broke the cursed vase. In revenge, a ghost stealth a great part of your money."
		$SkelBunny.money -= 100
	else:
		label_text = "You broke the cursed vase. In revenge, a ghost stealth all your money."
		$SkelBunny.money = 0
	$Timer2.start()

#nothing choice
func nothing_choice():
	n = 0
	label_text = "You broke the nothingness vase. Nothing happened."
	$Timer2.start()

#good choice
func good_choice():
	n = 0
	label_text = "YOU BROKE THE RICHNESS VASE! YOU FOUND A LOT OF MONEY!"
	if current_level > 20:
		$SkelBunny.money += 300
	elif current_level > 10:
		$SkelBunny.money += 200
	else:
		$SkelBunny.money += 100
	$Timer2.start()

#Second delay of text
func _on_Timer2_timeout():
	if n > label_text.length():
		show_end()
	else:
		n += 1
		$Timer2.start()
		$Label.text = label_text.substr(0, n)

#Shows the continue button
func show_end():
	$Button4.visible = true

#Continue with the adveture
func _on_Button4_pressed():
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
