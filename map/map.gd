extends Control

var current_level : int
var map : String = ""

const SKULL_ENEMY : PackedScene = preload("res://map/skull_enemy.tscn")
const START_ARROW : PackedScene = preload("res://map/start_arrow.tscn")

var symbols : Dictionary = {
	"S" : START_ARROW,
	"E" : SKULL_ENEMY
}

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
	#update the map with new information
# warning-ignore:return_value_discarded
	map_file.open("user://map.save", File.WRITE)
	map_file.store_line(map)
	map_file.close()
	draw_path()

#instance the sprites of the path taken
func draw_path():
	for x in range(0, current_level + 1):
		var button : TextureButton = symbols[map[x]].instance()
		get_parent().add_child(button)
		button.rect_global_position = get_node("Position2D" + String(x)).global_position
		button.disabled = true
		button.modulate = Color(0.38039, 0.38039, 0.38039, 1)
	draw_next_level()

#Instance the buttons for the next level
func draw_next_level():
	var n : int = current_level + 1
	var pos_n : int = int(rand_range(0, 3))
	var button : TextureButton = SKULL_ENEMY.instance()
	get_parent().add_child(button)
	if pos_n == 0:
		button.rect_global_position = get_node("Position2D" + String(n)).global_position
		button.rect_global_position.y -= 70
	elif pos_n == 1:
		button.rect_global_position = get_node("Position2D" + String(n)).global_position
	else:
		button.rect_global_position = get_node("Position2D" + String(n)).global_position
		button.rect_global_position.y += 70
