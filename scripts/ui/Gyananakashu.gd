extends Control

@onready var HUD = get_parent()
var shdrd = 'res://assets/shaders/shockwave.shader'

func showEffect():
	_createEffect()
	EventBus.emit_signal('showNPCNature')

func _createEffect():
	var rect = ColorRect.new()
	rect.material = ShaderMaterial.new()
	rect.material.shader = shdrd
	rect.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	var tween = create_tween().set_trans(Tween.EASE_IN).set_ease(Tween.EASE_OUT)
	tween.tween_property(rect.material, "shader_param/radius", 0.9, 0.7)
	#tween.tween_callback(rect, 'queue_free')
	HUD.add_child(rect)
