extends KinematicBody2D
class_name NPCBase

enum NATURE_KIND { good, bad }
enum JOBS {
	none,
	trade,
	game,
	quest,
	combat,
}
export(JOBS) var job = JOBS.none
export(NATURE_KIND) var nature = NATURE_KIND.good

func _ready():
	_defineJobs()

	# @test-code
	$Label.set_text(str(NATURE_KIND.keys()[nature] + ' : ' + JOBS.keys()[job]))

func _defineJobs():
	match job:
		JOBS.trade: _trader()
		JOBS.game: _gamer()

func _trader():
	print('traders union')

func _gamer():
	print('gamer union')

func _startInteraction():
	var dialog = Dialogic.start('what')
	# testing variables in dialog.
	Dialogic.set_variable('variant', 3)
	add_child(dialog)

func _on_Area2D_body_entered(body:Node):
	_startInteraction()
