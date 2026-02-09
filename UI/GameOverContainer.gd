class_name GameOverContainer
extends PanelContainer


#region Parameters

#endregion


#region Consts

#endregion


#region State
var score: int = 0
var currentPos: Vector2 = Vector2.ZERO
#endregion


#region Signals
signal gameOver
#endregion


#region Dependencies
@onready var restart: IconButton = $MarginContainer/GridContainer/Restart
@onready var scoreLabel: Label = %ScoreLabel
#endregion


#region Lifecycles

func _ready() -> void:
	Tools.connectSignal(restart.pressed, onRestart_pressed)
	currentPos = global_position
	global_position.y = -1000
	var tween: Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:y", currentPos.y, 1.0)
	await tween.finished
	scoreLabel.text = "游戏分数：%s" % score

#endregion


#region GetAndSets


#endregion


#region SignalHandlers

func onRestart_pressed() -> void:
	var tween: Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:y", -1000, 1.0)
	await tween.finished
	gameOver.emit()
	queue_free()

#endregion
