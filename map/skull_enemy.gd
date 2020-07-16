extends TextureButton

var desc : String = "Fight a regular battle."
var img : String = "res://map/skull_enemy-1.png.png"

#Change current scene to a fight
func _on_skull_enemy_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Battle/Battle.tscn")

#This executes every frame
func _physics_process(_delta):
	if is_hovered():
		get_parent().get_node("map").show_info(desc, img)
