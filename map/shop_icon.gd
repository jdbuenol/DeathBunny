extends TextureButton

var desc : String = "Buy some cards and some upgrades at exorbitant prices."
var img : String = "res://map/map_icons-3.png.png"

#change current scene to the shop
func _on_shop_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://shop/shop.tscn")

#This executes every frame
func _physics_process(_delta):
	if is_hovered():
		get_parent().get_node("map").show_info(desc, img)
