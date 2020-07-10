extends TextureButton

#change current scene to boss battle
func _on_boss_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Battle/Battle.tscn")
