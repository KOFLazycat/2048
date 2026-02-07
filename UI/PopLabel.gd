class_name PopLabel
extends Label


#region Parameters

#endregion


#region Consts

#endregion


#region State

#endregion


#region Signals

#endregion


#region Dependencies

#endregion


#region Lifecycles

func _ready() -> void:
	var tween: Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", position.y - 500, 1.0)
	tween.tween_property(self, "modulate:a", 0, 1.0)
	await tween.finished
	queue_free()

#endregion


#region GetAndSets


#endregion
