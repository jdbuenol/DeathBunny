extends TextureButton

var info : String = "Deal 1 damage to the nearest enemy.\nThen push him away 3 tiles."
var img : String = "res://cards/AttackCards/baseballBat/AttackCards-18.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
