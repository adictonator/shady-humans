extends KinematicBody2D

export var MAX_SPEED := 50
export var ACCELERATION := 0.1
export var FRICTION := 0.1

onready var playerAnimation = $AnimatedSprite

var velocity: Vector2 = Vector2.ZERO
enum STATE {CRAWL, WALK, RUN, IDLE, CLIMB}

onready var inventoryUI = get_parent().get_node('Inventory')
var isInventoryVisible = false

# Make crawl movement logic.
func crawl():
	MAX_SPEED = 10
	ACCELERATION = 2
	FRICTION = 2

#func _physics_process(_delta):

#	# @temp: Show inventory logic here for now?
#	if Input.is_action_just_pressed('toggleInventory'):
#		isInventoryVisible = !isInventoryVisible
#		inventoryUI.get_node('BG').visible = isInventoryVisible
#		#if isInventoryVisible:
#		#get_parent().get_node('Inventory/Panel').visible = true

#	var input = Vector2.ZERO
#	input.x = Input.get_action_strength('move_right') - Input.get_action_strength('move_left')
#	input.y = Input.get_action_strength('move_up') - Input.get_action_strength('move_down')

#	if input.x == 0 && input.y == 0:
#		applyFriction()
#		playerAnimation.animation = 'idle'

#	if input.x > 0:
#		playerAnimation.animation = 'walkRight'
#	else:
#		playerAnimation.animation = 'walkLeft'

#	if input.y > 0:
#		playerAnimation.animation = 'walkRight'
#	else:
#		playerAnimation.animation = 'walkLeft'

#	applyAcceleration(input)

#	velocity = move_and_slide(velocity, Vector2.UP)

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

func _physics_process(_delta):
	var direction = getInput()
	if direction.length() > 0:
		applyAcceleration(direction)
	else:
		applyFriction()

	velocity = move_and_slide(velocity)

func applyFriction():
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func applyAcceleration(direction):
	velocity = lerp(velocity, direction.normalized() * MAX_SPEED, ACCELERATION)
