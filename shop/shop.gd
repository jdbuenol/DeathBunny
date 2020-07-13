extends Control

const MARK_IN_MAP : String = "M"

var current_level : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")
const CARD_COST : PackedScene = preload("res://shop/card_cost.tscn")

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

#Upgrades to sell
const HEALTH_UPGRADE : PackedScene = preload("res://shop/upgrades/healthUpgrade.tscn")
const ENERGY_UPGRADE : PackedScene = preload("res://shop/upgrades/energyUpgrade.tscn")
const HEAL : PackedScene = preload("res://shop/upgrades/heal.tscn")
const SHIELD : PackedScene = preload("res://shop/upgrades/shieldUpgrade.tscn")

var all_cards : Array = [BASIC_ATTACK, LONG_RANGE_ATTACK, BOMB_ATTACK, BONE_ATTACK, BOW_ARROW, LONG_SWORD, NEAR_ATTACK, 
SACRIFICE_DAGGER, SNIPE_ATTACK, SPEAR_ATTACK]
var select_cards : Array = []
var all_upgrades : Array = [HEALTH_UPGRADE, ENERGY_UPGRADE, HEAL, SHIELD]

var old_man_phrases : Array = ["Its dangerous to go alone, take these.", "My little roguelike #2.", 
"Good luck in this run.", "Have you participated in a jam?", "Sometimes i see death people.",
"Isn't it hot down here?", "Hover one card to see the description.", "Death is just the beginning."]

var description : String

#This executes at the start of the scene
func _ready():
	randomize()
	$AnimatedSprite.playing = true

	#check skelbunny money
	$money.text = String($SkelBunny.money)
	
	description = old_man_phrases[int(rand_range(0, old_man_phrases.size()))]
	$"old man says-1png/Label".text = description
	
	#Checking current level
	update_current_level()
	
	#set the sale
	set_cards()
	set_upgrades()

#Check current level
func update_current_level():
	var file_of_current_level : File = File.new()
	if not file_of_current_level.file_exists("user://current_level.save"):
		return
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.READ)
	current_level = int(file_of_current_level.get_line())
	file_of_current_level.close()

#This executes each frame
func _physics_process(_delta):
	for card in select_cards:
		if card.hovered():
			$"old man says-1png/Label".text = card.DESCRIPTION
			if card.DESCRIPTION == "":
				$"old man says-1png/Label".text = card.description
			return
	$"old man says-1png/Label".text = description

#cards on sale
func set_cards():
	randomize()
	for _x in range(3):
		var card : TextureButton = all_cards[int(rand_range(0, all_cards.size()))].instance()
		add_child(card)
		card.rect_global_position = $Position2D.global_position
		card.price = int(rand_range(1, current_level)) * int(rand_range(1, current_level))
		var card_cost : Sprite = CARD_COST.instance()
		card_cost.get_node("Label").text = String(card.price)
		add_child(card_cost)
		card_cost.global_position = $Position2D.global_position
		card_cost.global_position.y += 185
		card_cost.global_position.x += 65
		$Position2D.global_position.x += 150
		select_cards.append(card)

#upgrades on sale
func set_upgrades():
	randomize()
	for _x in range(3):
		var upgrade : TextureButton = all_upgrades[int(rand_range(0, all_upgrades.size()))].instance()
		add_child(upgrade)
		upgrade.rect_global_position = $Position2D2.global_position
		var upgrade_cost : Sprite = CARD_COST.instance()
		upgrade_cost.get_node("Label").text = String(upgrade.price)
		add_child(upgrade_cost)
		upgrade_cost.global_position = $Position2D2.global_position
		upgrade_cost.global_position.y += 185
		upgrade_cost.global_position.x += 80
		$Position2D2.global_position.x += 170
		select_cards.append(upgrade)

#Continue with the adventure
func _on_continue_pressed():
	#Update the current level file
	var file_of_current_level : File = File.new()
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.WRITE)
	file_of_current_level.store_line(String(current_level + 1))
	file_of_current_level.close()
	#Update the hero status
	#Update the hero status
	var file_of_hero : File = File.new()
# warning-ignore:return_value_discarded
	file_of_hero.open("user://hero.save", File.WRITE)
	file_of_hero.store_line("max_hp " + String($SkelBunny.max_hp))
	file_of_hero.store_line("current_hp " + String($SkelBunny.hp))
	file_of_hero.store_line("max_energy " + String($SkelBunny.max_energy))
	file_of_hero.store_line("money " + String($SkelBunny.money))
	file_of_hero.store_line("shield " + String($SkelBunny.shield))
	file_of_hero.close()
	add_child(MAP.instance())

#This function update the player deck adding one card
func add_to_deck(card : String, price : int):
	var deck : File = File.new()
# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.READ_WRITE)
	deck.seek_end()
	deck.store_line(card + " 1")
	deck.close()
	
	$SkelBunny.money -= price
	$money.text = String($SkelBunny.money)

#Upgrade skelbunny health
func health_upgrade(upgrade : TextureButton):
	$SkelBunny.max_hp += upgrade.upgrade_size
	$SkelBunny.hp += upgrade.upgrade_size
	skelbunny_pay(upgrade)

#Upgrade skelbunny energy
func energy_upgrade(upgrade : TextureButton):
	$SkelBunny.max_energy += 1
	skelbunny_pay(upgrade)

#Heal to full life
func heal(upgrade : TextureButton):
	$SkelBunny.hp = $SkelBunny.max_hp
	skelbunny_pay(upgrade)

#Upgrade skelbunny shield
func shield_upgrade(upgrade : TextureButton):
	$SkelBunny.shield += upgrade.upgrade_size
	skelbunny_pay(upgrade)

#Function created to save lines of code
func skelbunny_pay(upgrade : TextureButton):
	$SkelBunny.money -= upgrade.price
	select_cards.erase(upgrade)
	upgrade.queue_free()
	$money.text = String($SkelBunny.money)
