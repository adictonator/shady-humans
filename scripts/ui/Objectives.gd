extends Control

var Items = {
	"cut-rope" : {
		"title": "Cut the rope",
		"XP": 10,
		"done": false,
	},
	"get-glass" : {
		"title": "Gte the glass",
		"XP": 10,
		"done": false,
	}
}

@onready var objectiveList = $P/M/V/List
@onready var objectiveItemTemplate = preload('res://scenes/ui/templates/ObjectiveItem.tscn')

var panelVisible = false
func _ready() -> void:
	EventBus.objectiveCompleted.connect(removeObjective)

	for itemKey in Items:
		var objectiveData = Items[itemKey]
		var label = objectiveItemTemplate.instantiate()
		# It's important to name the label as objective key for reference.
		label.name = itemKey
		label.set_text(objectiveData.title)
		objectiveList.add_child(label, true)

func _process(delta):
	if Input.is_action_just_pressed('toggleObjectives'):
		if ! panelVisible:
			panelVisible = true
			$AnimationPlayer.play('slide')
		else:
			$AnimationPlayer.play_backwards('slide')
			panelVisible = false

func removeObjective(objectiveID):
	var item = objectiveList.find_node(objectiveID, true, false)

	if item != null:
		objectiveList.remove_child(item)
		#Items.erase(objectiveID)
