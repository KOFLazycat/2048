class_name Slot
extends PanelContainer


#region Parameters

#endregion


#region Consts
const COLOR_1: Color = Color("#FAF8EF")
const COLOR_2: Color = Color("#EDE6D9")
const COLOR_3: Color = Color("#F5B17F")
const COLOR_4: Color = Color("#F89669")
const COLOR_5: Color = Color("#F97C5F")
const COLOR_6: Color = Color("#F95E3C")
const COLOR_7: Color = Color("#EDCF72")
const COLOR_8: Color = Color("#F2CE61")
const COLOR_9: Color = Color("#E5BF4E")
const COLOR_10: Color = Color("#E5B435")
const COLOR_11: Color = Color("#EDC22E")
const COLOR_12: Color = Color("#000000")
const COLOR_13: Color = Color("#3C3A32")
const COLOR_14: Color = Color("#25231E")

#endregion


#region State

var score: int : set = setScore

#endregion


#region Signals

#endregion


#region Dependencies
@onready var label: Label = %Label

#endregion


#region Lifecycles

func _ready() -> void:
	setScore(0)

#endregion


#region GetAndSets

func setScore(v: int) -> void:
	if v != score or v == 0:
		score = v
		if score > 0:
			label.show()
		else:
			label.hide()
		label.text = "%s" % score
		
		var tween: Tween = create_tween()
		match score:
			0: tween.tween_property(self, "modulate", COLOR_1, 0.5)
			2: tween.tween_property(self, "modulate", COLOR_2, 0.5)
			4: tween.tween_property(self, "modulate", COLOR_3, 0.5)
			8: tween.tween_property(self, "modulate", COLOR_4, 0.5)
			16: tween.tween_property(self, "modulate", COLOR_5, 0.5)
			32: tween.tween_property(self, "modulate", COLOR_6, 0.5)
			64: tween.tween_property(self, "modulate", COLOR_7, 0.5)
			128: tween.tween_property(self, "modulate", COLOR_8, 0.5)
			256: tween.tween_property(self, "modulate", COLOR_9, 0.5)
			512: tween.tween_property(self, "modulate", COLOR_10, 0.5)
			1024: tween.tween_property(self, "modulate", COLOR_11, 0.5)
			2048: tween.tween_property(self, "modulate", COLOR_12, 0.5)
			4096: tween.tween_property(self, "modulate", COLOR_13, 0.5)
			8192: tween.tween_property(self, "modulate", COLOR_14, 0.5)

#endregion
