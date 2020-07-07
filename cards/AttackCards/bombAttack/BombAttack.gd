extends TextureButton

const EFFECT_ON_TILES : String = "all"
const TYPE : String = "attack"
const DAMAGE : int = 3
const ENERGY : int = 2

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

#This executes when the player select the card
func _on_BombAttack_pressed():
	if get_parent().get_node("SkelBunny").energy < ENERGY:
		pass
	else:
		get_parent().attack(EFFECT_ON_TILES, DAMAGE, ENERGY)
		get_parent().battle_hand.erase(self)
		queue_free()
