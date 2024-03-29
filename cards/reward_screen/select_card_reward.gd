extends Control

#Common cards
const BASIC_ATTACK : PackedScene = preload("res://cards/AttackCards/basicAttack/BasicAttack_Reward.tscn")
const BOW_ARROW : PackedScene = preload("res://cards/AttackCards/bowArrow/BowArrow_Reward.tscn")
const SPEAR_ATTACK : PackedScene = preload("res://cards/AttackCards/spearAttack/SpearAttack_Reward.tscn")
const LONG_SWORD : PackedScene = preload("res://cards/AttackCards/longSword/longSword_Reward.tscn")
const BOMB_ATTACK : PackedScene = preload("res://cards/AttackCards/bombAttack/BombAttack_Reward.tscn")
const BONE_ATTACK : PackedScene = preload("res://cards/AttackCards/boneAttack/BoneAttack_Reward.tscn")
const NEAR_ATTACK : PackedScene = preload("res://cards/AttackCards/nearAttack/NearAttack_Reward.tscn")
const LONG_RANGE_ATTACK : PackedScene = preload("res://cards/AttackCards/LongRangeAttack/LongRangeAttack_Reward.tscn")
const SACRIFICE_DAGGER : PackedScene = preload("res://cards/AttackCards/sacrificeDagger/SacrificeDagger_Reward.tscn")
const SNIPE_ATTACK : PackedScene = preload("res://cards/AttackCards/snipeAttack/SnipeAttack_Reward.tscn")
const HAMMER_ATTACK : PackedScene = preload("res://cards/AttackCards/hammerAttack/HammerAttack_Reward.tscn")
const BASEBALL_BAT : PackedScene = preload("res://cards/AttackCards/baseballBat/BaseballBat_Reward.tscn")
const BASIC_WIND : PackedScene = preload("res://cards/OtherCards/basicWind/BasicWind_Reward.tscn")
const MED_KIT : PackedScene = preload("res://cards/OtherCards/medKit/MedKit_Reward.tscn")
const TORNADO : PackedScene = preload("res://cards/OtherCards/tornado/Tornado_Reward.tscn")
const CHARGE_ENERGY : PackedScene = preload("res://cards/OtherCards/chargeEnergy/ChargeEnergy_Reward.tscn")
const AXE_ATTACK : PackedScene = preload("res://cards/AttackCards/axeAttack/AxeAttack_Reward.tscn")

#Golden cards
const GOLDEN_BOMB : PackedScene = preload("res://cards/AttackCards/goldenBomb/GoldenBomb_Reward.tscn")
const GOLDEN_BONE : PackedScene = preload("res://cards/AttackCards/goldenBone/GoldenBone_Reward.tscn")
const GOLDEN_CROSS : PackedScene = preload("res://cards/AttackCards/goldenCross/GoldenCross_Reward.tscn")
const GOLDEN_SWORD : PackedScene = preload("res://cards/AttackCards/goldenSword/GoldenSword_Reward.tscn")
const GOLDEN_SPEAR : PackedScene = preload("res://cards/AttackCards/goldenSpear/GoldenSpear_Reward.tscn")
const GOLDEN_HAMMER : PackedScene = preload("res://cards/AttackCards/goldenHammer/GoldenHammer_Reward.tscn")
const GOLDEN_WIND : PackedScene = preload("res://cards/OtherCards/goldenWind/GoldenWind_Reward.tscn")
const GOLDEN_KIT : PackedScene = preload("res://cards/OtherCards/goldenKit/GoldenKit_Reward.tscn")
const GOLDEN_CHARGE : PackedScene = preload("res://cards/OtherCards/goldenCharge/GoldenCharge_Reward.tscn")
const GOLDEN_AXE : PackedScene = preload("res://cards/AttackCards/goldenAxe/GoldenAxe_Reward.tscn")

var type_of_rewards : String = "common"

var common_cards : Array = [BASIC_ATTACK, BOW_ARROW, SPEAR_ATTACK, LONG_SWORD, BOMB_ATTACK, BONE_ATTACK, NEAR_ATTACK,
LONG_RANGE_ATTACK, SACRIFICE_DAGGER, SNIPE_ATTACK, HAMMER_ATTACK, BASEBALL_BAT, BASIC_WIND, MED_KIT, TORNADO, CHARGE_ENERGY,
AXE_ATTACK]
var rare_cards : Array = [GOLDEN_BOMB, GOLDEN_BONE, GOLDEN_CROSS, GOLDEN_SWORD, GOLDEN_SPEAR, GOLDEN_HAMMER, GOLDEN_WIND,
GOLDEN_KIT, GOLDEN_CHARGE, GOLDEN_AXE]
var select_cards : Array = []

# This executes at the start of every frame
func _ready():
	randomize()
	for x in range(1, 4):
		var current_card : TextureButton
		if randf() > 0.1:
			current_card = common_cards[int(rand_range(0, common_cards.size()))].instance()
		else:
			current_card = rare_cards[int(rand_range(0, rare_cards.size()))].instance()
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
