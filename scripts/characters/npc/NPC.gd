extends KinematicBody2D
class_name NPC

enum NATURE_KIND { good, bad }
enum JOBS {
	none,
	trade,
	game,
	quest,
	combat,
}

onready var shader = preload('res://assets/shaders/colorOutline.shader')

export(JOBS) var job = JOBS.none
export(NATURE_KIND) var nature = NATURE_KIND.good
export var texture : StreamTexture

var dialogVariant = 1
var borderMixed
var borderSolid
var spriteNode
var activeNPC

func _ready():
	spriteNode = Sprite.new()
	spriteNode.texture = texture
	add_child(spriteNode)

	if nature == NATURE_KIND.bad:
		borderSolid = Color.red
	else:
		borderSolid = Color.green

	_defineJobs()

	# @test-code
	$Label.set_text(str(NATURE_KIND.keys()[nature] + ' : ' + JOBS.keys()[job]))

func _defineJobs():
	match job:
		JOBS.trade: _trader()
		JOBS.game: _gamer()

func _trader():
	pass

func _gamer():
	pass

func _startInteraction():
	var dialog = Dialogic.start('what')
	# testing variables in dialog.
	Dialogic.set_variable('variant', dialogVariant)
	add_child(dialog)
	EventBus.connect('showNPCNature', self, 'showNature')

func showNature() -> void:
	spriteNode.material = ShaderMaterial.new()
	spriteNode.material.shader = shader
	spriteNode.material.set_shader_param('width', 1)
	spriteNode.material.set_shader_param('color', borderSolid)
	EventBus.disconnect('showNPCNature', self, 'showNature')

func _on_Area2D_body_entered(body:Node):
	_startInteraction()
