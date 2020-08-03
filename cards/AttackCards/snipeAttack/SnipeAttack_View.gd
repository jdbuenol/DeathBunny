extends TextureButton

var info : String = "Deal 9 damage to the enemy in tile 9"
var img : String = "res://cards/AttackCards/snipeAttack/AttackCards-8.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
