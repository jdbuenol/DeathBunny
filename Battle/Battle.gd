extends Node2D

var current_level : int = 0
const SKEL_ENEMIE : PackedScene = preload("res://enemies/skel-enemie/SkelEnemie.tscn")
const BASIC_ATTACK : PackedScene = preload("res://cards/AttackCards/basicAttack/BasicAttack.tscn")
const MAP : PackedScene = preload("res://map/map.tscn")

var all_cards : Dictionary = {
	"basicAttack" : BASIC_ATTACK,
}

var battle_deck : Array = []
var enemies : Array = []
var battle_hand : Array = []
var battle_ended : bool = false
var enemy_turn : int = 0

#This executes at the start of the scene
func _ready():
	#Checking current level
	update_current_level()
	
	#Adding enemies
	if current_level <= 5:
		var skel_enemie : AnimatedSprite = SKEL_ENEMIE.instance()
		enemies.append(skel_enemie)
		for enemy in enemies:
			add_child(enemy)
			enemy.global_position.x = 77.352 + 110 * (enemy.initial_pos - 1)
			enemy.global_position.y = 446.848
	else:
		for _x in range(0, 2):
			var skel_enemie : AnimatedSprite = SKEL_ENEMIE.instance()
			enemies.append(skel_enemie)
			for enemy in enemies:
				add_child(enemy)
				enemy.global_position.x = 77.352 + 110 * (enemy.initial_pos - 1)
				enemy.global_position.y = 446.848

	#Loading deck
	reset_deck()
	
	#Start the battle
	start_turn()

#Check current level
func update_current_level():
	var file_of_current_level : File = File.new()
	if not file_of_current_level.file_exists("user://current_level.save"):
		return
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.READ)
	current_level = int(file_of_current_level.get_line())
	file_of_current_level.close()

#Reset deck
func reset_deck():
	battle_deck = []
	var deck : File = File.new()
	if not deck.file_exists("user://deck.save"):
		return
# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.READ)
	while deck.get_position() < deck.get_len():
		var current_line : Array = deck.get_line().split(" ", false)
		for _x in range(0, int(current_line[1])):
			battle_deck.append(all_cards[current_line[0]].instance())
	deck.close()

#This executes at the start of every turn
func start_turn():
	reset_deck()
	battle_hand = []
	var already_in_hand : Array = []
	$SkelBunny.energy = $SkelBunny.max_energy
	$EnergyOrb/Label.text = String($SkelBunny.energy)
	var x : int = int(rand_range(0, battle_deck.size()))
	while len(battle_hand) < 5:
		while x in already_in_hand:
			x = int(rand_range(0, battle_deck.size()))
		var current_card : TextureButton = battle_deck[x]
		already_in_hand.append(x)
		battle_hand.append(current_card)
		add_child(current_card)
		current_card.rect_global_position = $DeckPosition.global_position
		$DeckPosition.global_position.x += 110
	$DeckPosition.global_position.x = 14.964

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
	if !battle_ended:
		#Check if there is a hovered card and apply the effect of said hover
		var tiles_affected : bool = false
		for card in battle_hand:
			if card.TYPE == "attack" and card.hovered():
				affect_tiles(card.EFFECT_ON_TILES)
				tiles_affected = true
				break
		if !tiles_affected:
			affect_tiles("nothing")

#This executes when the player select an attack card
func attack(type : String, damage : int, energy : int):
	if type == "direct":
		var enemy : AnimatedSprite = get_nearest_enemy()
		enemy.hp -= damage
		if enemy.hp <= 0:
			enemies.erase(enemy)
			enemy.death()
		$SkelBunny.energy -= energy
		$EnergyOrb/Label.text = String($SkelBunny.energy)
		if enemies.size() == 0:
			battle_ended = true
			end_fight()
		elif $SkelBunny.energy == 0:
			end_turn()

#This executes when there is no more enemies
func end_fight():
	print("You did it, you won")
	for card in battle_hand:
		card.queue_free()
	add_child(MAP.instance())

#This executes when you have no more energy
func end_turn():
	for _x in range(0, battle_hand.size()):
		battle_hand.pop_back().queue_free()
	enemy_turn = 0
	$enemyDelay.start()

#This executes when a enemy hurt SkelBunny
func hurt_skelbunny(damage : int):
	if !battle_ended:
		$SkelBunny.hp -= damage
		$"Healt_points-1png/Label".text = String($SkelBunny.hp)
		if $SkelBunny.hp <= 0:
			$SkelBunny.death()
			game_over()
			battle_ended = true

#This executes when skelbunny dies
func game_over():
	print("You lose, try again")

#This is to reposition the enemy sprite
func reposition_enemy(enemy : AnimatedSprite):
	enemy.global_position.x = 77.352 + 110 * (enemy.current_pos - 1)

#Delay between enemies movements
func _on_enemyDelay_timeout():
	if enemy_turn >= enemies.size():
		start_turn()
		return
	enemies[enemy_turn].make_a_move()
	if !battle_ended:
		enemy_turn += 1
		$enemyDelay.start()
