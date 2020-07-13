extends TextureButton

const DESCRIPTION : String = ""

var description : String = "Heal to full life"
var price : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(0.7, 0.7, 0.7, 1)
	randomize()
	price = int(rand_range(1, get_parent().current_level)) * (get_parent().get_node("SkelBunny").max_hp - get_parent().get_node("SkelBunny").hp)

#This says if you are hovering the card or not
func hovered() -> bool:
	var mouse_pos : Vector2 = get_global_mouse_position()
	if mouse_pos.x > rect_global_position.x and mouse_pos.x < rect_global_position.x + 96:
		if mouse_pos.y > rect_global_position.y and mouse_pos.y < rect_global_position.y + 128:
			return true
	return false

#This executes every frame
func _physics_process(_delta):
	if hovered():
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.7, 0.7, 0.7, 1)

#This executes if you select this upgrade
func _on_heal_pressed():
	if get_parent().get_node("SkelBunny").money >= price:
		get_parent().heal(self)
