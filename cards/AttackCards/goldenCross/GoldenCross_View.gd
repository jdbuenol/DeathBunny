extends TextureButton

var info : String = "Deal 9 points of damage to the nearest enemy.\n Deal 25 instead if it is a boss."
var img : String = "res://cards/AttackCards/goldenCross/AttackCards-14.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
