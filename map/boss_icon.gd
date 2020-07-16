extends TextureButton

var desc : String = "Fight the boss to advance to the next world!"
var img : String = "res://map/map_icons-6.png.png"

#change current scene to boss battle
func _on_boss_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Battle/Battle.tscn")

#This executes every frame
func _physics_process(_delta):
	if is_hovered():
		get_parent().get_node("map").show_info(desc, img)
