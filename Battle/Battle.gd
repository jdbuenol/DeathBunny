extends Node2D

var current_level : int = 0

const SKEL_ENEMIE : PackedScene = preload("res://enemies/skel-enemie/SkelEnemie.tscn")
const BUN_BUN : PackedScene = preload("res://enemies/bunbun/BunBun.tscn")
const FLYING_SKULL : PackedScene = preload("res://enemies/flying-skull/FlyingSkull.tscn")
const DEATH_CANNON : PackedScene = preload("res://enemies/death-cannon/DeathCannon.tscn")
const LOVERS_HEART : PackedScene = preload("res://enemies/LoversHeart/LoversHeart.tscn")

var all_bosses : Array = [LOVERS_HEART]
var all_enemies : Array = [SKEL_ENEMIE, BUN_BUN, FLYING_SKULL]
var max_enemies_num : int = 0

const MAP : PackedScene = preload("res://map/map.tscn")
const REWARD_SCREEN : PackedScene = preload("res://cards/reward_screen/select_card_reward.tscn")
const DECK_SCREEN : PackedScene = preload("res://cards/deck.tscn")
const GAME_OVER_BUTTON : PackedScene = preload("res://Battle/game over/gameOverButton.tscn")

const MARK_IN_MAP : String = "E"

var all_cards : Dictionary = {
	"basicAttack" : preload("res://cards/AttackCards/basicAttack/BasicAttack.tscn"),
	"bowArrow" : preload("res://cards/AttackCards/bowArrow/BowArrow.tscn"),
	"spearAttack" : preload("res://cards/AttackCards/spearAttack/SpearAttack.tscn"),
	"longSword" : preload("res://cards/AttackCards/longSword/longSword.tscn"),
	"bombAttack" : preload("res://cards/AttackCards/bombAttack/BombAttack.tscn"),
	"boneAttack" : preload("res://cards/AttackCards/boneAttack/BoneAttack.tscn"),
	"nearAttack" : preload("res://cards/AttackCards/nearAttack/NearAttack.tscn"),
	"longRangeAttack" : preload("res://cards/AttackCards/LongRangeAttack/LongRangeAttack.tscn"),
	"sacrificeDagger" : preload("res://cards/AttackCards/sacrificeDagger/SacrificeDagger.tscn"),
	"snipeAttack" : preload("res://cards/AttackCards/snipeAttack/SnipeAttack.tscn"),
	"goldenBomb" : preload("res://cards/AttackCards/goldenBomb/GoldenBomb.tscn"),
	"goldenBone" : preload("res://cards/AttackCards/goldenBone/GoldenBone.tscn"),
	"goldenCross" : preload("res://cards/AttackCards/goldenCross/GoldenCross.tscn"),
	"goldenSword" : preload("res://cards/AttackCards/goldenSword/GoldenSword.tscn"),
	"goldenSpear" : preload("res://cards/AttackCards/goldenSpear/GoldenSpear.tscn")
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
	
	#Updating visuals
	if current_level <= 10:
		pass
	elif current_level <= 20:
		$SkelBunny.modulate = Color(1, 0.8, 0.8, 1)
		$"Backgrounds-1png".texture = load("res://Battle/Background section 1/Backgrounds-2.png.png")
		for x in range(1, 10):
			get_node("tile" + String(x)).modulate = Color(1, 0.8, 0.8, 1)
	elif current_level <= 30:
		$SkelBunny.modulate = Color(0.8, 0.8, 1, 1)
		$"Backgrounds-1png".texture = load("res://Battle/Background section 1/Backgrounds-3.png.png")
		for x in range(1, 10):
			get_node("tile" + String(x)).modulate = Color(0.8, 0.8, 1, 1)
	#Updating labels
	$"Healt_points-1png/Label".text = String($SkelBunny.hp) + "/" + String($SkelBunny.max_hp)
	$EnergyOrb/Label.text = String($SkelBunny.energy) + "/" + String($SkelBunny.max_energy)
	$"coin-label".text = String($SkelBunny.money)
	$"Healt_points-1png/Label2".text = String($SkelBunny.shield)
	
	#Adding enemies
	if current_level == 10:
		var enemy : AnimatedSprite = all_bosses[int(rand_range(0, all_bosses.size()))].instance()
		enemy.initial_pos = 9
		enemies.append(enemy)
	else:
		randomize()
		if current_level < 10:
			instance_enemies(6)
		elif current_level < 20:
			instance_enemies(5)
		elif current_level < 30:
			instance_enemies(4)
	for enemy in enemies:
		add_child(enemy)
		enemy.global_position.x = 77.352 + 110 * (enemy.initial_pos - 1)
		enemy.global_position.y = 446.848
		if "Flying" in enemy.name:
			enemy.global_position.y -= 100
		if current_level > 20:
			enemy.modulate = Color(0.8, 0.8, 1, 1)
			enemy.hp *= 3
			enemy.take_damage(0)
		elif current_level > 10:
			enemy.modulate = Color(1, 0.8, 0.8, 1)
			enemy.hp *= 2
			enemy.take_damage(0)
	max_enemies_num = enemies.size()

	#Loading deck
	reset_deck()
	
	#Start the battle
	start_turn()

#Instance enemies
func instance_enemies(min_pos : int):
	for x in range(min_pos, 10):
		if rand_range(0, 1) > 0.5:
			if x == 9:
				all_enemies.append(DEATH_CANNON)
			var enemy : AnimatedSprite = all_enemies[int(rand_range(0, all_enemies.size()))].instance()
			enemies.append(enemy)
			enemy.initial_pos = x
	if enemies.size() == 0:
		enemies.append(SKEL_ENEMIE.instance())
		enemies[0].initial_pos = 9

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
	$EnergyOrb/Label.text = String($SkelBunny.energy) + "/" + String($SkelBunny.max_energy)
	var x : int = int(rand_range(0, battle_deck.size()))
	if battle_deck.size() <= 5:
		for card in battle_deck:
			battle_hand.append(card)
			add_child(card)
			card.rect_global_position = $DeckPosition.global_position
			$DeckPosition.global_position.x += 160
	else:
		while len(battle_hand) < 5:
			while x in already_in_hand:
				x = int(rand_range(0, battle_deck.size()))
			var current_card : TextureButton = battle_deck[x]
			already_in_hand.append(x)
			battle_hand.append(current_card)
			add_child(current_card)
			current_card.rect_global_position = $DeckPosition.global_position
			$DeckPosition.global_position.x += 160
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

#This function return the second nearest enemy
func second_nearest_enemy() -> AnimatedSprite:
	var nearest_position : int = get_nearest_enemy().current_pos
	var nearest_pos : int = 10
	var second_enemy : AnimatedSprite
	for enemy in enemies:
		if enemy.current_pos < nearest_pos and enemy.current_pos > nearest_position:
			second_enemy = enemy
			nearest_pos = enemy.current_pos
	return second_enemy

#This function return the farthest enemy
func farthest_enemy() -> AnimatedSprite:
	var farthest_pos : int = 1
# warning-ignore:unused_variable
	var farthest_enemy : AnimatedSprite
	for enemy in enemies:
		if enemy.current_pos > farthest_pos:
			farthest_enemy = enemy
			farthest_pos = enemy.current_pos
	return farthest_enemy

#This function executes when you hover an attack card
#It will shadow the tiles affected by said card
func affect_tiles(type : String):
	if type == "direct":
		var max_pos : int = get_nearest_enemy().current_pos
		for x in range(2, max_pos + 1):
			get_node("tile" + String(x)).modulate = Color(1, 0.265625, 0.265625, 1)
	elif type == "nothing":
		if current_level <= 10:
			for x in range(1, 10):
				get_node("tile" + String(x)).modulate = Color(1, 1, 1, 1)
		elif current_level <= 20:
			for x in range(1, 10):
				get_node("tile" + String(x)).modulate = Color(1, 0.7, 0.7, 1)
		elif current_level <= 30:
			for x in range(1, 10):
				get_node("tile" + String(x)).modulate = Color(0.7, 0.7, 1, 1)
	elif type == "piercing":
		var max_pos : int = get_nearest_enemy().current_pos
		for x in range(2, max_pos + 1):
			get_node("tile" + String(x)).modulate = Color(1, 0.265625, 0.265625, 1)
		if enemies.size() >= 2:
			var second_pos : AnimatedSprite = second_nearest_enemy()
			if second_pos != null:
				for x in range(max_pos + 1, second_pos.current_pos + 1):
					get_node("tile" + String(x)).modulate = Color(1, 0.53, 0.53, 1)
	elif type == "all":
		for x in range(2, 10):
			get_node("tile" + String(x)).modulate = Color(1, 0.265625, 0.265625, 1)
	elif type == "near":
		get_node("tile2").modulate = Color(1, 0.265625, 0.265625, 1)
	elif type == "farth":
		var min_pos : int = farthest_enemy().current_pos
		for x in range(min_pos, 10):
			get_node("tile" + String(x)).modulate = Color(1, 0.265625, 0.265625, 1)
	elif type == "snipe":
		$tile9.modulate = Color(1, 0.265625, 0.265625, 1)

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
	if $deckButton.is_hovered():
		$deckButton.modulate = Color(1, 1, 1, 1)
	else:
		$deckButton.modulate = Color(0.8, 0.8, 0.8, 1)

#This executes when the player select an attack card
func attack(type : String, damage : int, energy : int):
	$SkelBunny.energy -= energy
	$EnergyOrb/Label.text = String($SkelBunny.energy) + "/" + String($SkelBunny.max_energy)
	#If the target is the nearest enemy
	if type == "direct":
		var enemy : AnimatedSprite = get_nearest_enemy()
		enemy.take_damage(damage)
		if enemy.hp <= 0:
			enemy.death()
			enemies.erase(enemy)
	#If the target is the nearest enemy(X2 damage if it's flying')
	elif type == "air":
		var enemy : AnimatedSprite = get_nearest_enemy()
		enemy.take_damage(damage * 2 if enemy.flying else damage)
		if enemy.hp <= 0:
			enemy.death()
			enemies.erase(enemy)
	#If the attack is piercing
	elif type == "piercing":
		var enemy : AnimatedSprite = get_nearest_enemy()
		enemy.take_damage(damage)
		if enemies.size() >= 2:
			var second_enemy : AnimatedSprite = second_nearest_enemy()
			if second_enemy != null:
				second_enemy.take_damage(int(damage / 2.0))
				if second_enemy.hp <= 0:
					enemies.erase(second_enemy)
					second_enemy.death()
		if enemy.hp <= 0:
			enemy.death()
			enemies.erase(enemy)
	#If the attack has a lasting effect
	elif type == "lasting":
		var enemy : AnimatedSprite = get_nearest_enemy()
		enemy.take_damage(damage)
		if enemy.hp <= 0:
			enemy.death()
			enemies.erase(enemy)
			if enemies.size() >= 1:
				attack("direct", 3, 0)
				return
	#If the target are all the enemies
	elif type == "all":
		for enemy in enemies:
			enemy.take_damage(damage)
			if enemy.hp <= 0:
				enemy.death()
				enemies.erase(enemy)
	#If the target is tile 1
	elif type == "near":
		for enemy in enemies:
			if enemy.current_pos == 2:
				enemy.take_damage(damage)
				if enemy.hp <= 0:
					enemy.death()
					enemies.erase(enemy)
				break
	#If the target is the farthest enemy
	elif type == "farth":
		var enemy : AnimatedSprite = farthest_enemy()
		enemy.take_damage(damage)
		if enemy.hp <= 0:
			enemy.death()
			enemies.erase(enemy)
	#If the target is in the tile 9
	elif type == "snipe":
		for enemy in enemies:
			if enemy.current_pos == 9:
				enemy.take_damage(damage)
				if enemy.hp <= 0:
					enemy.death()
					enemies.erase(enemy)
				break
	#Special attack
	elif type == "cross":
		var enemy : AnimatedSprite = get_nearest_enemy()
		if enemy.boss:
			enemy.take_damage(18)
		else:
			enemy.take_damage(9)
		if enemy.hp <= 0:
			enemy.death()
			enemies.erase(enemy)
	if enemies.size() == 0:
		battle_ended = true
		end_fight()

#This executes when there is no more enemies
func end_fight():
	print("You did it, you won")
	for card in battle_hand:
		card.queue_free()
	
	#Update the current level file
	var file_of_current_level : File = File.new()
# warning-ignore:return_value_discarded
	file_of_current_level.open("user://current_level.save", File.WRITE)
	file_of_current_level.store_line(String(current_level + 1))
	file_of_current_level.close()
	
	#Update the hero status
	var file_of_hero : File = File.new()
# warning-ignore:return_value_discarded
	file_of_hero.open("user://hero.save", File.WRITE)
	file_of_hero.store_line("max_hp " + String($SkelBunny.max_hp))
	file_of_hero.store_line("current_hp " + String($SkelBunny.hp))
	file_of_hero.store_line("max_energy " + String($SkelBunny.max_energy))
	for x in range(max_enemies_num):
		$SkelBunny.money += int(rand_range(0, current_level + 1))
	$"coin-label".text = String($SkelBunny.money)
	file_of_hero.store_line("money " + String($SkelBunny.money))
	file_of_hero.store_line("shield " + String($SkelBunny.shield))
	file_of_hero.close()

	add_child(REWARD_SCREEN.instance())

#This open the map to select the next level
func open_map():
	add_child(MAP.instance())

#This executes when a enemy hurt SkelBunny
func hurt_skelbunny(damage : int):
	if !battle_ended:
		$SkelBunny.take_damage(damage)

#This executes when skelbunny dies
func game_over():
	battle_ended = true
	$end_turn.queue_free()
	var game_over_button : Button = GAME_OVER_BUTTON.instance()
	add_child(game_over_button)
	game_over_button.rect_global_position = $gameOverPosition.global_position
	for card in battle_hand:
		card.queue_free()
		$end_turn.queue_free()
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

#This executes when the player end his turn
func _on_end_turn_pressed():
	for _x in range(0, battle_hand.size()):
		battle_hand.pop_back().queue_free()
	enemy_turn = 0
	$enemyDelay.start()

func add_two_skelenemies(pos : int):
	var enemy : AnimatedSprite = SKEL_ENEMIE.instance()
	enemies.append(enemy)
	enemy.initial_pos = pos
	add_child(enemy)
	enemy.global_position.x = 77.352 + 110 * (enemy.initial_pos - 1)
	enemy.global_position.y = 446.848
	enemy = SKEL_ENEMIE.instance()
	enemies.append(enemy)
	if pos == 9:
		enemy.initial_pos = 8
	else:
		enemy.initial_pos = pos + 1
	add_child(enemy)
	enemy.global_position.x = 77.352 + 110 * (enemy.initial_pos - 1)
	enemy.global_position.y = 446.848

func _on_deckButton_pressed():
	add_child(DECK_SCREEN.instance())
