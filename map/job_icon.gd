extends TextureButton

var desc : String = "Work in a bad-paid part-time job and earn a bit of money (and stress) without fighting."
var img : String = "res://map/map_icons-7.png.png"

#change current scene to job scene
func _on_job_icon_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://job/JobPoint.tscn")

#This executes every frame
func _physics_process(_delta):
	if is_hovered():
		get_parent().get_node("map").show_info(desc, img)
