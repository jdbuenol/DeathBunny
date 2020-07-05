extends Control

#Start the game
func _on_Start_pressed():
	#File for saving the deck of cards
	var deck : File = File.new()
# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.WRITE)
	deck.store_line("basicAttack 5")
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
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Battle/Battle.tscn")

#Exit to Desktop
func _on_Button_pressed():
	get_tree().quit()
