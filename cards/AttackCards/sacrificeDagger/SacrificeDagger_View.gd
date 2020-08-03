extends TextureButton

var info : String = "Deal 1 damage to yourself.\nDeal 9 damage to the nearest enemy"
var img : String = "res://cards/AttackCards/sacrificeDagger/AttackCards-5.png.png"

func _physics_process(_delta):
	if is_hovered():
		get_parent().show_info(info, img)
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.8, 0.8, 0.8, 1)
