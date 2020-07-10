extends ColorRect

#get back to main title
func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://MainTitle/MainTitle.tscn")
