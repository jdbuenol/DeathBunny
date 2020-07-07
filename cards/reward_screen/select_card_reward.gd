extends Control

const BASIC_ATTACK_REWARD : PackedScene = preload("res://cards/AttackCards/basicAttack/BasicAttack_Reward.tscn")
const BOW_ARROW_REWARD : PackedScene = preload("res://cards/AttackCards/bowArrow/BowArrow_Reward.tscn")
const SPEAR_ATTACK_REWARD : PackedScene = preload("res://cards/AttackCards/spearAttack/SpearAttack_Reward.tscn")

var type_of_rewards : String = "common"

var common_cards : Array = [BASIC_ATTACK_REWARD, BOW_ARROW_REWARD, SPEAR_ATTACK_REWARD]
var select_cards : Array = []

# This executes at the start of every frame
func _ready():
	for x in range(1, 4):
		var current_card : TextureButton = common_cards[int(rand_range(0, common_cards.size()))].instance()
		add_child(current_card)
		select_cards.append(current_card)
		current_card.rect_global_position = get_node("Position2D" + str(x)).global_position

#This executes each frame
func _physics_process(_delta):
	for card in select_cards:
		if card.hovered():
			$description.text = card.DESCRIPTION
			return
	$description.text = "HOVER A CARD TO SEE THE DESCRIPTION"

#This function update the player deck adding one card
func add_to_deck(card : String):
	var deck : File = File.new()
# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.READ_WRITE)
	deck.seek_end()
	deck.store_line(card + " 1")
	deck.close()
	get_parent().open_map()
	queue_free()
