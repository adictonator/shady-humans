extends TextureRect

@onready var cursor := $Cursor
@onready var hitArea := $HitArea
@onready var pp = get_parent()

var width :float
var hitAreaPos :float
var hitAreaSize :float
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	width = size.x
	randomizeHitAreaPos()

	hitAreaPos = hitArea.rect_position.x #start point
	hitAreaSize = hitAreaPos + hitArea.size.x #end point

func _process(_delta):
	var curPos = cursor.rect_position.x

	if Input.is_action_just_pressed('usePower'):
		pp.showEffect(curPos >= hitAreaPos && curPos <= hitAreaSize)
		queue_free()

func randomizeHitAreaPos():
	var g = width - hitArea.size.x
	var newPos = rng.randf_range(0, g)
	hitArea.rect_position.x = newPos
