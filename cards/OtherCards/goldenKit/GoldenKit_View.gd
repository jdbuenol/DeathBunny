extends TextureButton

var info : String = "Heal yourself 1 point."
var img : String = "res://cards/OtherCards/goldenKit/OtherCards-2.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
