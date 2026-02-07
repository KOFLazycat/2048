class_name MainButtonGroup
extends VBoxContainer

#region Parameters

#endregion


#region Consts

#endregion


#region State

#endregion


#region Signals

#endregion


#region Dependencies

@onready var close: IconButton = $Close
@onready var restart: IconButton = $Restart
@onready var undo: IconButton = $Undo
@onready var sound: IconButton = $Sound
@onready var slotGridContainer: SlotGridContainer = $"../VBoxContainer/PanelContainer/MarginContainer/SlotGridContainer"

#endregion


#region Lifecycles

func _ready() -> void:
	Tools.connectSignal(close.pressed, onClose_pressed)
	Tools.connectSignal(restart.pressed, onRestart_pressed)
	Tools.connectSignal(undo.pressed, onUndo_pressed)
	Tools.connectSignal(sound.pressed, onSound_pressed)

#endregion


#region GetAndSets


#endregion


#region SignalHandles

func onClose_pressed() -> void:
	get_tree().quit()


func onRestart_pressed() -> void:
	slotGridContainer.restartGame()


func onUndo_pressed() -> void:
	pass


func onSound_pressed() -> void:
	pass

#endregion


#region Tools


#endregion
