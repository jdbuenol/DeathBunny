extends TextureButton

#change current scene to health camp
func _on_health_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://healthPoint/HealthPoint.tscn")
