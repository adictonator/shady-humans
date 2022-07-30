extends CanvasLayer
class_name Inventory

# This file will contain the logic for inventory, I believe.
# Inventory can be displayed anytime in the game so it makes sense if it is already
# a child of the root. Then we just show/hide it.
onready var inventorySlotTemplate = preload('res://scenes/ui/templates/InventorySlot.tscn')
onready var inventoryGrid = $BG/M/V/ScrollContainer/GridContainer

func _ready():
	# Need to load the inventory from a file here.
	# Also populate the slots count.

	for i in PlayerData.data.keys():
		var itemIdx = PlayerData.data[i].item

		# we also show empty slots so there can be slots with no items in them
		# @todo: rework this logic later
		if itemIdx != null:
			var slotData = GameData.data[str(itemIdx)]
			var inventorySlot = inventorySlotTemplate.instance()
			var gradient = Gradient.new()
			gradient.set_color(0, ColorN(slotData.texture))

			var gg = GradientTexture.new()
			gg.set_gradient(gradient)
			inventorySlot.get_node('Icon').texture = gg
			# get item from the GameData var
			# get item texture
			# append the texture to the slot
			# append the slot to the grid
			inventoryGrid.add_child(inventorySlot, true)

func addItem(item) -> void:
	var inventorySlot = inventorySlotTemplate.instance()
	inventorySlot.get_node('Icon').texture = item
	inventoryGrid.add_child(inventorySlot, true)
