extends TextureButton

var info : String = "Deal 1 point of damage to the nearest enemy"
var img : String = "res://cards/AttackCards/boneAttack/AttackCards-7.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
