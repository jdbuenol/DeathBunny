extends TextureButton

var desc : String = "Health fountain, recover your life."
var img : String = "res://map/map_icons-4.png.png"

#change current scene to health camp
func _on_health_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://healthPoint/HealthPoint.tscn")

#This executes every frame
func _physics_process(_delta):
	if is_hovered():
		get_parent().get_node("map").show_info(desc, img)
