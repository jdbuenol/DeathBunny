extends TextureButton

#change current scene to the shop
func _on_shop_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://shop/shop.tscn")
