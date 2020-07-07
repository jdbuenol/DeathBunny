extends TextureButton

const DESCRIPTION : String = "Deal 1 of damage to yourself.\nDeal 9 of damage to the nearest enemy"

#This executes at the start of the scene
func _ready():
	$ColorRect.visible = true

#This executes every frame
func _physics_process(_delta):
	if hovered():
		$ColorRect.visible = false
	else:
		$ColorRect.visible = true

#This says if you are hovering the card or not
func hovered() -> bool:
	var mouse_pos : Vector2 = get_global_mouse_position()
	if mouse_pos.x > rect_global_position.x and mouse_pos.x < rect_global_position.x + 96:
		if mouse_pos.y > rect_global_position.y and mouse_pos.y < rect_global_position.y + 128:
			return true
	return false

func _on_SacrificeDaggerReward_pressed():
	get_parent().add_to_deck("sacrificeDagger")
