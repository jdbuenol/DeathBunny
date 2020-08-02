extends TextureButton

const DESCRIPTION : String = "Start next turn with 1 extra energy."

var card_name : String = "chargeEnergy"
var price : int = 0

#This executes at the start of the scene
func _ready():
	$Sprite/Label.text = "1"
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

#This executes when you select this card
func _on_ChargeEnergyReward_pressed():
	if price == 0:
		get_parent().add_to_deck(card_name)
		queue_free()
	else:
		if get_parent().get_node("SkelBunny").money >= price:
			get_parent().add_to_deck(card_name, price)
			get_parent().select_cards.erase(self)
			queue_free()
