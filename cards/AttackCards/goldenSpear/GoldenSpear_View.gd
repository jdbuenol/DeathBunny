extends TextureButton

var info : String = "Deal 6 damage to the nearest enemy.\n And 3 of damage to the second nearest."
var img : String = "res://cards/AttackCards/goldenSpear/AttackCards-12.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
