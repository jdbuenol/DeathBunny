extends KinematicBody2D

#Movement constants
const FLOOR : Vector2 = Vector2(0, -1)
const GRAVITY : int = 160
const SPEED : int = 300

#Vector for movmenet
var movement : Vector2 = Vector2(0, 0)

#This executes at the start of the scene
func _ready():
	$AnimatedSprite.play("Idle")

#This executes every frame
func _physics_process(_delta):
	
	#Movement and input check
	movement.y = GRAVITY
	if Input.is_action_pressed("ui_left"):
		movement.x = -SPEED
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		movement.x = SPEED
		$AnimatedSprite.flip_h = false
	else:
		movement.x = 0
	movement = move_and_slide(movement, FLOOR)
