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
	current_level = get_parent().current_level
	
	#load the path taken
	var map_file : File = File.new()
	if not map_file.file_exists("user://map.save"):
		return
# warning-ignore:return_value_discarded
	map_file.open("user://map.save", File.READ)
	map = map_file.get_line()
	map_file.close()
	print(current_level)
	draw_path()

#instance the sprites of the path taken
func draw_path():
	for x in range(0, current_level):
		var button : TextureButton = symbols[map[x]].instance()
		get_parent().add_child(button)
		button.rect_global_position = get_node("Position2D" + String(x)).global_position
		button.disabled = true
