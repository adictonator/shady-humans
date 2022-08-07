extends TextureRect

onready var cursor := $Cursor
onready var hitArea := $HitArea
var width :float
var hitAreaPos :float
var hitAreaSize :float
onready var pp = get_parent()
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	width = rect_size.x
	randomizeHitAreaPos()

	hitAreaPos = hitArea.rect_position.x #start point
	hitAreaSize = hitAreaPos + hitArea.rect_size.x #end point

func _process(_delta):
	var curPos = cursor.rect_position.x

	if Input.is_action_just_pressed('usePower'):
		pp.showEffect()
		queue_free()
	#if curPos >= hitAreaPos && curPos <= hitAreaSize:

func randomizeHitAreaPos():
	var g = width - hitArea.rect_size.x
	var newPos = rng.randf_range(0, g)
	hitArea.rect_position.x = newPos
