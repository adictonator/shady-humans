extends StateMachine

func _ready():
	addState('crawl')
	addState('idle')
	addState('walk')
	addState('run')
	addState('jump')

	setState(states.crawl)

func _stateLogic(delta):
	#parent.crawl()
	pass
