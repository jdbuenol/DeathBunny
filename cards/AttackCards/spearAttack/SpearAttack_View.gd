extends TextureButton

var info : String = "Deal 3 of damage to the nearest enemy.\n And 1 of damage to the second nearest."
var img : String = "res://cards/AttackCards/spearAttack/AttackCards-3.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
