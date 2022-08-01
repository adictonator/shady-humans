extends TextureRect

func get_drag_data(position):
	var data = {}
	data['originalTexture'] = texture

	var dragTexture = TextureRect.new()
	dragTexture.expand = true
	dragTexture.texture = texture
	dragTexture.rect_size = Vector2(100, 100)

	# Center the dragged texture to mouse cursor.
	var control = Control.new()
	control.add_child(dragTexture)
	dragTexture.rect_position = -0.5 * dragTexture.rect_size

	set_drag_preview(control)

	return data

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	texture = data['originalTexture']