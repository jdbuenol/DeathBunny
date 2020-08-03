extends TextureButton

var info : String = "Deal 3 damage to the nearest enemy.\n If it die deal 3 damage to the next enemy."
var img : String = "res://cards/AttackCards/longSword/AttackCards-4.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
