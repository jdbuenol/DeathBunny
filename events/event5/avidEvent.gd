extends Control

const MARK_IN_MAP : String = "V"
var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")

var label_text : String = "You have found an altar dedicated to avid, goddess of life. Would you like to make a monetary offer?"
var n : int = 0

#This executes at the start of the scene
func _ready():
	$Button.visible = false
	$Button2.visible = false
	$Button3.visible = false
	update_current_level()
	if current_level < 10:
		$Button.text = "MAKE AN OFFER! (Lose 30 coins and gain 1 max hp)"
	elif current_level < 20:
		$Button.text = "MAKE AN OFFER! (Lose 65 coins and gain 2 max hp)"
	else:
		$Button.text = "MAKE AN OFFER! (Lose 100 coins and gain 3 max hp)"
	$Timer.start()

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
		$Button2.visible = true
	else:
		n += 1
		$Label.text = label_text.substr(0, n)
		$Timer.start()

#Make the offer!
func _on_Button_pressed():
	$Button.queue_free()
	$Button2.queue_free()
	n = 0
	var offer_made : bool = false
	if current_level < 10:
		if $SkelBunny.money >= 30:
			offer_made = true
			$SkelBunny.money -= 30
			$SkelBunny.max_hp += 1
			$SkelBunny.hp += 1
	elif current_level < 20:
		if $SkelBunny.money >= 65:
			offer_made = true
			$SkelBunny.money -= 65
			$SkelBunny.max_hp += 2
			$SkelBunny.hp += 2
	else:
		if $SkelBunny.money >= 100:
			offer_made = true
			$SkelBunny.money -= 100
			$SkelBunny.max_hp += 3
			$SkelBunny.hp += 3
	if offer_made:
		label_text = "After putting the coins in the altar they melted into a heart-shaped cookie that you proceed to eat. You have received avid's blessing"
	else:
		label_text = "You don't have enough money to make the offer. Better continue with your adventure"
	$Timer2.start()

#Continue with the adventure
func _on_Button2_pressed():
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

#Second text delay
func _on_Timer2_timeout():
	if n >= label_text.length():
		$Button3.visible = true
	else:
		n += 1
		$Label.text = label_text.substr(0, n)
		$Timer2.start()
