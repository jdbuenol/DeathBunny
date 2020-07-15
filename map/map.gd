extends Control

var current_level : int
var map : String = ""

const SKULL_ENEMY : PackedScene = preload("res://map/skull_enemy.tscn")
const START_ARROW : PackedScene = preload("res://map/start_arrow.tscn")
const SHOP_ICON : PackedScene = preload("res://map/shop_icon.tscn")
const HEALTH_ICON : PackedScene = preload("res://map/health_icon.tscn")
const EVENT_ICON : PackedScene = preload("res://map/event_icon.tscn")
const BOSS_ICON : PackedScene = preload("res://map/boss_icon.tscn")

var symbols : Dictionary = {
	"S" : START_ARROW,
	"E" : SKULL_ENEMY,
	"M" : SHOP_ICON,
	"V" : EVENT_ICON,
	"H" : HEALTH_ICON
}

var forks : Array = [SHOP_ICON, HEALTH_ICON, EVENT_ICON]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	current_level = get_parent().current_level
	
	#load the path taken
	var map_file : File = File.new()
	if not map_file.file_exists("user://map.save"):
		return
# warning-ignore:return_value_discarded
	map_file.open("user://map.save", File.READ)
	map = map_file.get_line() + get_parent().MARK_IN_MAP
	map_file.close()
	
	#Check if new world
	if current_level == 10:
		map = "S"
	#update the map with new information
# warning-ignore:return_value_discarded
	map_file.open("user://map.save", File.WRITE)
	map_file.store_line(map)
	map_file.close()
	draw_path()

#instance the sprites of the path taken
func draw_path():
	var n : int = current_level + 1
	while n > 10:
		n -= 10
	for x in range(0, n):
		var button : TextureButton = symbols[map[x]].instance()
		get_parent().add_child(button)
		button.rect_global_position = get_node("Position2D" + String(x)).global_position
		button.disabled = true
		button.modulate = Color(0.38039, 0.38039, 0.38039, 1)
	draw_next_level()

#Instance the buttons for the next level
func draw_next_level():
	var n : int = current_level + 1
	while n > 10:
		n -= 10
	if n == 10:
		var button : TextureButton = BOSS_ICON.instance()
		get_parent().add_child(button)
		button.rect_global_position = get_node("Position2D" + String(n)).global_position
	else:
		var pos_n : int = int(rand_range(0, 3))
		var button : TextureButton = SKULL_ENEMY.instance()
		get_parent().add_child(button)
		if pos_n == 0:
			button.rect_global_position = get_node("Position2D" + String(n)).global_position
			button.rect_global_position.y -= 70
			draw_forks(button.rect_global_position.y + 70, button.rect_global_position.y + 140)
		elif pos_n == 1:
			button.rect_global_position = get_node("Position2D" + String(n)).global_position
			draw_forks(button.rect_global_position.y - 70, button.rect_global_position.y + 70)
		else:
			button.rect_global_position = get_node("Position2D" + String(n)).global_position
			button.rect_global_position.y += 70
			draw_forks(button.rect_global_position.y - 70, button.rect_global_position.y - 140)

#Instance the buttons for the next level forks
func draw_forks(pos1 : float, pos2 : float):
	var n : int = current_level + 1
	while n > 10:
		n -= 10
	var button1 : TextureButton = forks[int(rand_range(0, forks.size()))].instance()
	var button2 : TextureButton = forks[int(rand_range(0, forks.size()))].instance()
	get_parent().add_child(button1)
	get_parent().add_child(button2)
	button1.rect_global_position = get_node("Position2D"+String(n)).global_position
	button2.rect_global_position = get_node("Position2D"+String(n)).global_position
	button1.rect_global_position.y = pos1
	button2.rect_global_position.y = pos2
