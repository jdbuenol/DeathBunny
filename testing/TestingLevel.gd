extends Node2D

const SKEL_ENEMIE : PackedScene = preload("res://enemies/skel-enemie/SkelEnemie.tscn")
const BASIC_ATTACK : PackedScene = preload("res://cards/AttackCards/basicAttack/BasicAttack.tscn")

var all_cards : Dictionary = {
	"basicAttack" : BASIC_ATTACK,
}

var battle_deck : Array = []
var enemies : Array = []
var battle_hand : Array = []

#This executes at the start of the scene
func _ready():
	
	#Adding enemies
	var skel_enemie : AnimatedSprite = SKEL_ENEMIE.instance()
	enemies.append(skel_enemie)
	for enemy in enemies:
		add_child(enemy)
		enemy.global_position.x = 77.352 + 110 * (enemy.initial_pos - 1)
		enemy.global_position.y = 446.848
	
	#Loading deck
	var deck = File.new()
	if not deck.file_exists("user://deck.save"):
		return
	deck.open("user://deck.save", File.READ)
	while deck.get_position() < deck.get_len():
		var current_line : Array = deck.get_line().split(" ", false)
		for _x in range(0, int(current_line[1])):
			battle_deck.append(all_cards[current_line[0]].instance())
	
	#Start the battle
	start_turn()

#This executes at the start of every turn
func start_turn():
	battle_hand = []
	var x : int = int(rand_range(0, battle_deck.size()))
	while len(battle_hand) < 5:
		while battle_deck[x] in battle_hand:
			x = int(rand_range(0, battle_deck.size()))
		var current_card : TextureButton = battle_deck[x]
		battle_hand.append(current_card)
		add_child(current_card)
		current_card.rect_global_position = $DeckPosition.global_position
		$DeckPosition.global_position.x += 110

#This function return the nearest enemy
func get_nearest_enemy() -> AnimatedSprite:
	var nearest_enemy : AnimatedSprite
	var nearest_pos : int = 10
	for enemy in enemies:
		if enemy.current_pos < nearest_pos:
			nearest_enemy = enemy
			nearest_pos = enemy.current_pos
	return nearest_enemy

#This function executes when you hover an attack card
#It will shadow the tiles affected by said card
func affect_tiles(type : String):
	if type == "direct":
		var max_pos : int = get_nearest_enemy().current_pos
		for x in range(2, max_pos + 1):
			get_node("tile" + String(x)).modulate = Color(1, 0.265625, 0.265625, 1)
	elif type == "nothing":
		for x in range(1, 10):
			get_node("tile" + String(x)).modulate = Color(1, 1, 1, 1)

#This executes at the start of every frame
func _physics_process(_delta):
	
	#Check if there is a hovered card and apply the effect of said hover
	var tiles_affected : bool = false
	for card in battle_hand:
		if card.type == "attack" and card.hovered():
			affect_tiles(card.effect_on_tiles)
			tiles_affected = true
			break
	if !tiles_affected:
		affect_tiles("nothing")
