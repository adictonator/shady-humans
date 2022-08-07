extends KinematicBody2D

enum NATURE { good, bad }
enum JOBS {
	none,
	trade,
	game,
	quest,
	combat,
}
export(JOBS) var jobs = JOBS.none
export(NATURE) var nature = NATURE.good

func _ready():
	# on base of nature, set color type?
	if nature == NATURE.good:
		print('he good kimfd')
	else:
		print('c')


func _on_Area2D_body_entered(body:Node):
	var dialog = Dialogic.start('what')
	add_child(dialog)
	# body is player
