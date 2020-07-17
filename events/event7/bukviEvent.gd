extends Control

const MARK_IN_MAP : String = "V"
var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")

var label_text : String = "You have found an altar dedicated to bukvi, god of the cards. Would you like to make a blood offer?"
var n : int = 0

var rare_cards : Array = ["goldenBomb", "goldenBone", "goldenCross", "goldenSpear", "goldenSword"]
var offer_made : bool = false

#This executes at the start of the scene
func _ready():
	$Button.visible = false
	$Button2.visible = false
	$Button3.visible = false
	update_current_level()
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
	if n >= label_text.length():
		$Button.visible = true
		$Button2.visible = true
	else:
		n += 1
		$Label.text = label_text.substr(0, n)
		$Timer.start()

#Make the offer
func _on_Button_pressed():
	$Button.queue_free()
	$Button2.queue_free()
	n = 0
	if $SkelBunny.max_hp >= 2:
		$SkelBunny.max_hp -= 1
		if $SkelBunny.hp > $SkelBunny.max_hp:
			$SkelBunny.hp = $SkelBunny.max_hp
		offer_made = true
		label_text = "After making the offer the altar shrinked into a golden card. You got bukvi's blessing."
	else:
		label_text = "You don't have enough life points to make the offer. Better continue with your journey."
	$Timer2.start()

#Second text delay
func _on_Timer2_timeout():
	if n >= label_text.length():
		$Button3.visible = true
	else:
		n += 1
		$Label.text = label_text.substr(0, n)
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
	if offer_made:
		randomize()
		var deck_file : File = File.new()
		if !deck_file.file_exists("user://deck.save"):
			return
# warning-ignore:return_value_discarded
		deck_file.open("user://deck.save", File.READ_WRITE)
		deck_file.seek_end()
		deck_file.store_line(rare_cards[int(rand_range(0, rare_cards.size()))] + " 1")
	add_child(MAP.instance())
