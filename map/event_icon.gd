extends TextureButton

const event1 : String = "res://events/event1/vasesEvent.tscn"
const event2 : String = "res://events/event2/jamEvent.tscn"
const event3 : String = "res://events/event3/patreonEvent.tscn"
const event4 : String = "res://events/event4/electronEvent.tscn"
const event5 : String = "res://events/event5/avidEvent.tscn"
const event6 : String = "res://events/event6/rustningEvent.tscn"
const event7 : String = "res://events/event7/bukviEvent.tscn"
const event8 : String = "res://events/event8/coinEvent.tscn"

var events : Array = [event1, event2, event3, event4, event5, event6, event7, event8]

var desc : String = "Nobody knows what could happen here."
var img : String = "res://map/map_icons-5.png.png"

#change current scene to event scene
func _on_event_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(events[int(rand_range(0, events.size()))])

#This executes every frame
func _physics_process(_delta):
	if is_hovered():
		get_parent().get_node("map").show_info(desc, img)
