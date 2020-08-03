extends TextureButton

var info : String = "Deal 2 damage to the nearest enemy.\nThen push him away 1 tile."
var img : String = "res://cards/AttackCards/hammerAttack/AttackCards-16.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
