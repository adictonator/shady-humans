extends CanvasLayer

onready var startButton = $"%StartButton"
onready var quitButton = $"%QuitButton"

func _ready():
	startButton.grab_focus()

func _onStartButtonPressed():
	get_tree().change_scene('res://scenes/levels/Basement.tscn')


func _onQuitButtonPressed():
	get_tree().quit()
