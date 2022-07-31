extends KinematicBody2D

const GRAVITY = 4
const JUMP_MIN = -70
const JUMP_MAX = -120
export var MAX_SPEED := 50
export var ACCELERATION := 10
export var FRICTION := 10

var canJump = true

onready var playerAnimation = $AnimatedSprite

var velocity: Vector2 = Vector2.ZERO
enum STATE {CRAWL, WALK, RUN, IDLE, JUMP, CLIMB}

onready var inventoryUI = get_parent().get_node('Inventory')
var isInventoryVisible = false

# Make crawl movement logic.
func crawl():
	canJump = false
	MAX_SPEED = 10
	ACCELERATION = 2
	FRICTION = 2

func interact():
	print('I am the interact window.')

func _physics_process(_delta):

	# @temp: Show inventory logic here for now?
	if Input.is_action_just_pressed('toggleInventory'):
		isInventoryVisible = !isInventoryVisible
		inventoryUI.get_node('BG').visible = isInventoryVisible
		#if isInventoryVisible:
		#get_parent().get_node('Inventory/Panel').visible = true

	var input = Vector2.ZERO
	input.x = Input.get_action_strength('move_right') - Input.get_action_strength('move_left')

	if input.x == 0:
		applyFriction()
		playerAnimation.animation = 'idle'
	else:
		applyAcceleration(input.x)

		if input.x < 0:
			playerAnimation.animation = 'walkLeft'
		else:
			playerAnimation.animation = 'walkRight'

	if canJump:
		jump()

	velocity = move_and_slide(velocity, Vector2.UP)

func jump():
	if is_on_floor():
		if Input.is_action_just_pressed('ui_up'):
			velocity.y = JUMP_MAX
	else:
		# Variable jump.
		if Input.is_action_just_released('ui_up') && velocity.y < JUMP_MIN:
			velocity.y = JUMP_MIN

		if velocity.y > 0:
			velocity.y += GRAVITY

func applyGravity():
	velocity.y += GRAVITY

func applyFriction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)

func applyAcceleration(direction):
	# Walk movement.
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCELERATION)
