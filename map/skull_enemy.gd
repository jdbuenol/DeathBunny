extends TextureButton

#Change current scene to a fight
func _on_skull_enemy_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Battle/Battle.tscn")
