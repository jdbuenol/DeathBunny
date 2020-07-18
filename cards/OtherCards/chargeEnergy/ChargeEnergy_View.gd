extends TextureButton

var info : String = "Start next turn with 1 extra energy."
var img : String = "res://cards/OtherCards/chargeEnergy/OtherCards-6.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
