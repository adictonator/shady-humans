extends Area2D
class_name InteractableObject

var isInteracting :bool = false

onready var inventory = get_viewport().get_node('Inventory')
onready var interactionPopup = preload('res://scenes/ui/InteractionPopup.tscn').instance()

func _process(delta):
	if isInteracting && Input.is_action_just_pressed('interact'):
		# Push the item to the inventory slot (for now) directly.
		addToInventory()
		pass

func addToInventory():
	# Get the item sprite/texture.
	var itemTexture = self.get_node('Sprite').texture

	# Move the item into inventory. in any inventory slot for now
	_moveItemToInventory(itemTexture)

func _moveItemToInventory(item):
	# @todo: fix this
	get_node('/root/Basement/Inventory').addItem(item)

	# remove the item from the scene
	self.queue_free()

func _displayInteractionPopup() -> void:
	interactionPopup.rect_position.y = -30
	add_child(interactionPopup)
	interactionPopup.get_node('AnimationPlayer').play('fadeIn')
	isInteracting = true

func _removeInteractionPopup() -> void:
	interactionPopup.get_node('AnimationPlayer').play_backwards('fadeIn')
	isInteracting = false
	# should I remove the element or just hide it?
	#get_viewport().remove_child(interactionPopup)

