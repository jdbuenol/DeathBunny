extends TextureButton

var info : String = "Push away the nearest enemy 2 tile."
var img : String = "res://cards/OtherCards/goldenWind/OtherCards-4.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
