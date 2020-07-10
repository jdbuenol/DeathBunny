extends Control

const MARK_IN_MAP : String = "M"

var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")

#cards to sell
const BASIC_ATTACK : PackedScene = preload("res://cards/AttackCards/basicAttack/BasicAttack_Reward.tscn")
const LONG_RANGE_ATTACK : PackedScene = preload("res://cards/AttackCards/LongRangeAttack/LongRangeAttack_Reward.tscn")
const BOMB_ATTACK : PackedScene = preload("res://cards/AttackCards/bombAttack/BombAttack_Reward.tscn")
const BONE_ATTACK : PackedScene = preload("res://cards/AttackCards/boneAttack/BoneAttack_Reward.tscn")
const BOW_ARROW : PackedScene = preload("res://cards/AttackCards/bowArrow/BowArrow_Reward.tscn")
const LONG_SWORD : PackedScene = preload("res://cards/AttackCards/longSword/longSword_Reward.tscn")
const NEAR_ATTACK : PackedScene = preload("res://cards/AttackCards/nearAttack/NearAttack_Reward.tscn")
const SACRIFICE_DAGGER : PackedScene = preload("res://cards/AttackCards/sacrificeDagger/SacrificeDagger_Reward.tscn")
const SNIPE_ATTACK : PackedScene = preload("res://cards/AttackCards/snipeAttack/SnipeAttack_Reward.tscn")
const SPEAR_ATTACK : PackedScene = preload("res://cards/AttackCards/spearAttack/SpearAttack_Reward.tscn")

var all_cards : Array = [BASIC_ATTACK, LONG_RANGE_ATTACK, BOMB_ATTACK, BONE_ATTACK, BOW_ARROW, LONG_SWORD, NEAR_ATTACK, 
SACRIFICE_DAGGER, SNIPE_ATTACK, SPEAR_ATTACK]

#This executes at the start of the scene
func _ready():
	$AnimatedSprite.playing = true

	#Checking current level
	update_current_level()
	
	#set the sale
	set_cards()

#Check current level
func update_current_level():
	var file_of_current_level : File = File.new()
	if not file_of_current_level.file_exists("user://current_level.save"):
		return
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.READ)
	current_level = int(file_of_current_level.get_line())
	file_of_current_level.close()

#cards on sale
func set_cards():
	for _x in range(3):
		var card : TextureButton = all_cards[int(rand_range(0, all_cards.size()))].instance()
		add_child(card)
		card.rect_global_position = $Position2D.global_position
		$Position2D.global_position.x += 100

#Continue with the adventure
func _on_continue_pressed():
	#Update the current level file
	var file_of_current_level : File = File.new()
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.WRITE)
	file_of_current_level.store_line(String(current_level + 1))
	file_of_current_level.close()

	add_child(MAP.instance())

#This function update the player deck adding one card
func add_to_deck(card : String):
	var deck : File = File.new()
# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.READ_WRITE)
	deck.seek_end()
	deck.store_line(card + " 1")
	deck.close()
