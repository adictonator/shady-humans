extends InteractableObject

func _onBodyEntered(body:Node):
	# Check if the body is player.
	# Or just use layers and mask?

	_displayInteractionPopup()
	#body.interact()


func _onBodyExited(body:Node):
	# Hide the popup here.
	_removeInteractionPopup()
