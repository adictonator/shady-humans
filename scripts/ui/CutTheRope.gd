extends CanvasLayer

const VALID_KEYS = {
	"up": {
		"code": KEY_UP
	},
	"down": {
		"code": KEY_DOWN
	},
	"left": {
		"code": KEY_LEFT
	},
	"right": {
		"code": KEY_RIGHT
	}
}
onready var progressBar = $ProgressBar
onready var keySymbol = $Key/P/Code
onready var keyTimer = $Key
onready var keyTimerValue = $Key.value
onready var timer = $Key/Timer

var rng = RandomNumberGenerator.new()
var waitTime
var activeKey

# has objectives
# so pull that objective task from the objective class and show here?
# hard coded I guess
func _ready():
	waitTime = timer.wait_time
	rng.randomize()
	_showKey()
	keyTimer.max_value = timer.wait_time

func _process(delta):
	waitTime -= 1 * delta
	waitTime = max(waitTime, 0)
	keyTimer.value = waitTime

func _on_Timer_timeout():
	$AnimationPlayer.play('wobble')

	# Wait for the animation to finish.
	yield($AnimationPlayer, 'animation_finished')
	_showKey()

func _showKey():
	timer.start()
	waitTime = timer.wait_time
	var key = VALID_KEYS.keys()[ rng.randi() % VALID_KEYS.size() ]
	var selectedKey = VALID_KEYS[ key ]

	keySymbol.set_text(key)
	activeKey = selectedKey.code

func _unhandled_key_input(ev):
	# Check if the correct, assigned key is pressed.
	if ev.is_pressed() and not ev.echo:
		if ev.scancode == activeKey:
			updateProgress(20)
			_showKey()
		else:
			# do some visual effect here
			$AnimationPlayer.play('wobble')


func updateProgress(updateVal):
	# get the remaining time when key was pressed
	var pressedTime = timer.time_left
	var maxValue = progressBar.max_value
	#print('ok time', pressedTime)

	#var progressValue = ( pressedTime / 8 ) * 12
	var progressValue = 50
	#print('okd here', progressValue)

	var currentProgress = progressBar.value
	var newVal = min(currentProgress + progressValue, 101)

	if newVal >= maxValue:
		# Game finished.
		# show some visual effect of "success" like the rope gets cut/breaks
		# close the whole game UI/remove the UI
		self.queue_free()
		# Provide some XP
		EventBus.emit_signal('objectiveCompleted', 'cut-rope')

	if newVal < maxValue:
		progressBar.set_value(newVal)

