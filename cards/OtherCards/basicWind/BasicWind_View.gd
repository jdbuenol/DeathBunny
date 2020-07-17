extends TextureButton

var info : String = "Push away the nearest enemy 1 tile."
var img : String = "res://cards/OtherCards/basicWind/OtherCards-3.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
