extends Node
class_name StateMachine

var states = {}
var state = null setget setState
var prevState = null
onready var parent = get_parent()

func _process(delta):
	if state != null:
		_stateLogic(delta)
		var transition = _getTransition(delta)

		if transition != null:
			setState(transition)

func _stateLogic(_delta):
	pass

func _getTransition(_delta):
	pass

func _enterState(_newState, _oldState):
	pass

func _exitState(_oldState, _newState):
	pass

func addState(stateName):
	states[stateName] = states.size()

func setState(newState):
	prevState = state
	state = newState

	if prevState != null:
		_exitState(prevState, newState)

	if newState != null:
		_enterState(newState, prevState)
