extends TextureButton

const EFFECT_ON_TILES : String = "direct"
const TYPE : String = "attack"
const DAMAGE : int = 2
const ENERGY : int = 1

func _ready():
	$ColorRect.visible = true

func _physics_process(_delta):
	if hovered():
		$ColorRect.visible = false
	else:
		$ColorRect.visible = true

func hovered() -> bool:
	var mouse_pos : Vector2 = get_global_mouse_position()
	if mouse_pos.x > rect_global_position.x and mouse_pos.x < rect_global_position.x + 96:
		if mouse_pos.y > rect_global_position.y and mouse_pos.y < rect_global_position.y + 128:
			return true
	return false

func _on_BasicAttack_pressed():
	get_parent().attack(EFFECT_ON_TILES, DAMAGE, ENERGY)
	get_parent().battle_hand.erase(self)
	queue_free()
