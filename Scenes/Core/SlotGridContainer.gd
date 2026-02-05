class_name SlotGridContainer
extends GridContainer

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
	var children: Array[Node] = get_children()
	for i: int in range(children.size()):
		var s: Slot = children[i] as Slot
		if s:
			if i == 0:
				s.score = 0
			else:
				s.score = pow(2, i%14)

#endregion


#region GetAndSets


#endregion
