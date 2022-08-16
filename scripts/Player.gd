extends CharacterBody2D
class_name Player

enum STATE {CRAWL, WALK, RUN, IDLE, CLIMB}
@export var MAX_SPEED: float = 50.0
@export var ACCELERATION: float = 0.1
@export var FRICTION: float = 0.1
@export var color: Color

@onready var levelRoot = get_parent()
@onready var playerAnimation = $AnimatedSprite
@onready var accuracyMeter = preload('res://scenes/ui/templates/AccuracyMeter.tscn')

#var velocity: Vector2 = Vector2.ZERO
var isInventoryVisible: bool = false

# Make crawl movement logic.
func crawl():
	MAX_SPEED = 10
	ACCELERATION = 2
	FRICTION = 2

func getInput():
	var input = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		input.x += 1
		playerAnimation.animation = 'walkRight'
	if Input.is_action_pressed('move_left'):
		input.x -= 1
		playerAnimation.animation = 'walkLeft'
	if Input.is_action_pressed('move_down'):
		input.y += 1
	if Input.is_action_pressed('move_up'):
		input.y -= 1

	if input == Vector2.ZERO:
		playerAnimation.animation = 'idle'
	return input

func _handleMovement():
	var direction = getInput()
	if direction.length() > 0:
		applyAcceleration(direction)
	else:
		applyFriction()

	#velocity = move_and_slide(velocity)
	move_and_slide()

func _physics_process(_delta):
	_handleMovement()

func _showAccuracyMeter():
	# Make it a child of the "power" node in HUD
	$"%HUD/Gyananakashu".add_child(accuracyMeter.instantiate())

func applyFriction():
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func applyAcceleration(direction):
	velocity = lerp(velocity, direction.normalized() * MAX_SPEED, ACCELERATION)
