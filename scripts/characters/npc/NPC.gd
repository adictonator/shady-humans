extends CharacterBody2D
class_name NPC

enum JOBS {
	none,
	trade,
	game,
	quest,
	combat,
}
enum NATURE {
	good,
	bad
}
var shader = 'res://assets/shaders/glowingOutline.shader'

@export var job: JOBS = JOBS.none
@export var nature: NATURE = NATURE.good
@export var texture: CompressedTexture2D

var dialogVariant = 1
var borderMixed
var borderSolid
var spriteNode

func _ready():
	spriteNode = Sprite2D.new()
	spriteNode.texture = texture
	add_child(spriteNode)

	if nature == NATURE.bad:
		borderSolid =  Color.RED
	else:
		borderSolid =  Color.DARK_GREEN

	_defineJobs()

	# @test-code
	$Label.set_text(str(nature + ' : ' + JOBS.keys()[job]))

func _defineJobs():
	match job:
		JOBS.trade: _trader()
		JOBS.game: _gamer()

func _trader():
	pass

func _gamer():
	pass

func _startInteraction():
	pass
	#var dialog = Dialogic.start('what')
	## testing variables in dialog.
	#Dialogic.set_variable('variant', dialogVariant)
	#add_child(dialog)

	# warning-ignore:return_value_discarded
	#EventBus.connect('showNPCNature', self, 'showNature')

func showNature(isAccurate: bool) -> void:
	print('is acc', isAccurate)

	var borderType = borderSolid if isAccurate else borderMixed

	spriteNode.material = ShaderMaterial.new()
	spriteNode.material.shader = shader
	spriteNode.material.set_shader_param('width', 15)
	spriteNode.material.set_shader_param('width_speed', 2)
	spriteNode.material.set_shader_param('outline_color', borderType)
	#EventBus.disconnect('showNPCNature', self, 'showNature')

func _on_Area2D_body_entered(_body:Node):
	pass
	#_startInteraction()
