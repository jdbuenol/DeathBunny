extends TextureButton

var effect_on_tiles : String = "direct"
var type : String = "attack"

func _ready():
	$ColorRect.visible = false

func _physics_process(_delta):
	if hovered():
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false

func hovered() -> bool:
	var mouse_pos : Vector2 = get_global_mouse_position()
	if mouse_pos.x > rect_global_position.x and mouse_pos.x < rect_global_position.x + 96:
		if mouse_pos.y > rect_global_position.y and mouse_pos.y < rect_global_position.y + 128:
			return true
	return false
