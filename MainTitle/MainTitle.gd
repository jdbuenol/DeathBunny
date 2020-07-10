extends Control

#All cards
var all_cards : Array = ["basicAttack", "bowArrow", "spearAttack", "longSword", "bombAttack", "boneAttack", "nearAttack", 
"longRangeAttack", "sacrificeDagger", "snipeAttack"]

#Start the game
func _on_Start_pressed():
	randomize()
	#File for saving the deck of cards
	var deck : File = File.new()
# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.WRITE)
	for _x in range(5):
		deck.store_line("basicAttack 1")
		deck.store_line(all_cards[int(rand_range(0, all_cards.size()))] + " 1")
	deck.close()
	
	#File for saving the current level
	var current_level : File = File.new()
# warning-ignore:return_value_discarded
	current_level.open("user://current_level.save", File.WRITE)
	current_level.store_line("1")
	current_level.close()
# warning-ignore:return_value_discarded

	#File for saving the path in the map
	var map : File = File.new()
#warning-ignore:return_value_discarded
	map.open("user://map.save", File.WRITE)
	map.store_line("S")
	map.close()
	#File for saving skelBunny progress
	var hero : File = File.new()
	hero.open("user://hero.save", File.WRITE)
	hero.store_line("max_hp 5")
	hero.store_line("current_hp 5")
	hero.store_line("max_energy 1")
	hero.store_line("money 0")
	hero.close()
	
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Battle/Battle.tscn")

#Exit to Desktop
func _on_Button_pressed():
	get_tree().quit()
