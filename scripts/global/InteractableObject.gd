extends Area2D
class_name InteractableObject

var isInteracting :bool = false

onready var interactionPopup = preload('res://scenes/ui/InteractionPopup.tscn').instance()
func _ready():
	print('test only')

func _process(delta):
	# Interaction key binding here?
	if isInteracting && Input.is_action_just_pressed('interact'):
		print('hmmm ok')
		pass

# Need a function that detects interaction?

func _displayInteractionPopup() -> void:
	#get_viewport().add_child(interactionPopup)
	interactionPopup.rect_position.y = -30
	add_child(interactionPopup)

	# Position the popup right above the object and make it stick to it.
	interactionPopup.get_node('AnimationPlayer').play('fadeIn')

	isInteracting = true
	# after interaction, hide the popup?
	# hide popup for obtainable/consumable/one-time objects?
	# add the picked up item in inventory?

func _removeInteractionPopup() -> void:
	interactionPopup.get_node('AnimationPlayer').play_backwards('fadeIn')
	isInteracting = false
	# should I remove the element or just hide it?
	#get_viewport().remove_child(interactionPopup)

