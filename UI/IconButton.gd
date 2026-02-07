@tool
class_name IconButton
extends PanelContainer

#region Parameters
@export var icon: Texture: set = setIcon
@export var text: String: set = setText
#endregion


#region Consts

#endregion


#region State

#endregion


#region Signals
signal pressed
#endregion


#region Dependencies
@onready var textureRect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var marginContainer: MarginContainer = $MarginContainer
#endregion


#region Lifecycles

func _ready() -> void:
	Tools.connectSignal(mouse_entered, on_mouse_entered)
	Tools.connectSignal(mouse_exited, on_mouse_exited)
	pivot_offset = size / 2
	setIcon(icon)
	setText(text)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			pressed.emit()

#endregion


#region GetAndSets

func setIcon(v: Texture) -> void:
	if v != icon:
		icon = v
	
	if icon != null and is_node_ready():
		textureRect.texture = icon

func setText(v: String) -> void:
	if v != text:
		text = v
	if not text.is_empty() and is_node_ready():
		label.text = text

#endregion


#region SignalHandlers

func on_mouse_entered() -> void:
	z_index = 99
	var tween: Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(marginContainer, "rotation", PI/2, 0.3)
	tween.tween_property(marginContainer, "position:x", -16, 0.3)
	tween.tween_property(self, "scale", Vector2.ONE * 1.25, 0.3)
	tween.tween_property(self, "position:x", -16, 0.3)
	tween.tween_property(label, "modulate:a", 1, 0.3)


func on_mouse_exited() -> void:
	var tween: Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(marginContainer, "rotation", 0, 0.3)
	tween.tween_property(marginContainer, "position:x", 0, 0.3)
	tween.tween_property(self, "scale", Vector2.ONE, 0.3)
	tween.tween_property(self, "position:x", 0, 0.3)
	tween.tween_property(label, "modulate:a", 0, 0.3)
	await tween.finished
	z_index = 0

#endregion
