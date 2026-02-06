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

@onready var restart: Button = $Restart
@onready var slotGridContainer: SlotGridContainer = $"../VBoxContainer/PanelContainer/MarginContainer/SlotGridContainer"

#endregion


#region Lifecycles

func _ready() -> void:
	Tools.connectSignal(restart.pressed, onRestart_pressed)

#endregion


#region GetAndSets


#endregion


#region SignalHandles

func onRestart_pressed() -> void:
	slotGridContainer.restartGame()

#endregion


#region Tools


#endregion
