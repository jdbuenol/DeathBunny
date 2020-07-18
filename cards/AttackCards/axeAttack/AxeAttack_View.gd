extends TextureButton

var info : String = "Deal 3 of damage to the nearest enemy.\nIf you kill it recover 1 point of energy."
var img : String = "res://cards/AttackCards/axeAttack/AttackCards-21.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
