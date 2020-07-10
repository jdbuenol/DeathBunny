extends Control

var deck : File = File.new()

var cards : Dictionary = {}
var cards_instances : Array = []

var all_cards : Dictionary = {
	"basicAttack" : preload("res://cards/AttackCards/basicAttack/BasicAttack_View.tscn"),
	"longRangeAttack" : preload("res://cards/AttackCards/LongRangeAttack/LongRangeAttack_View.tscn"),
	"bombAttack" : preload("res://cards/AttackCards/bombAttack/BombAttack_View.tscn"),
	"boneAttack" : preload("res://cards/AttackCards/boneAttack/BoneAttack_View.tscn"),
	"bowArrow" : preload("res://cards/AttackCards/bowArrow/BowArrow_View.tscn"),
	"longSword" : preload("res://cards/AttackCards/longSword/longSword_View.tscn"),
	"nearAttack" : preload("res://cards/AttackCards/nearAttack/NearAttack_View.tscn"),
	"sacrificeDagger" : preload("res://cards/AttackCards/sacrificeDagger/SacrificeDagger_View.tscn"),
	"snipeAttack" : preload("res://cards/AttackCards/snipeAttack/SnipeAttack_View.tscn"),
	"spearAttack" : preload("res://cards/AttackCards/spearAttack/SpearAttack_View.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Checking the cards in the deck
	if not deck.file_exists("user://deck.save"):
		return
	# warning-ignore:return_value_discarded
	deck.open("user://deck.save", File.READ)
	while deck.get_position() < deck.get_len():
		var line : String = deck.get_line()
		var data : Array = line.split(" ")
		if data[0] in cards.keys():
			cards[data[0]] += 1
		else:
			cards[data[0]] = 1
	
	var hor_counter : int = 0
	#adding cards to the showcase
	for card in cards:
		var current_card : TextureButton = all_cards[card].instance()
		cards_instances.append(current_card)
		add_child(current_card)
		current_card.rect_global_position = $cardsPos.global_position
		var number : Label = Label.new()
		add_child(number)
		number.rect_global_position = $cardsPos.global_position
		number.rect_global_position.y += 100
		number.text = String(cards[card])
		$cardsPos.global_position.x += 100
		hor_counter += 1
		if hor_counter == 6:
			hor_counter = 0
			$cardsPos.global_position.x -= 600
			$cardsPos.global_position.y += 200

#This executes every frame
func _physics_process(_delta):
	var anyone_is_hovered : bool = false
	for card in cards_instances:
		if card.is_hovered():
			anyone_is_hovered = true
	if !anyone_is_hovered:
		$info.text = ""
		$Sprite.texture = null

#When you hover a card
func show_info(card : String, img : String):
	$info.text = card
	$Sprite.texture = load(img)

func _on_Button_pressed():
	queue_free()
