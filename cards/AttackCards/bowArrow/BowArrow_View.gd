extends TextureButton

var info : String = "Deal 3 damage to the nearest enemy.\n6 if it is flying"
var img : String = "res://cards/AttackCards/bowArrow/AttackCards-2.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
