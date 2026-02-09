class_name SlotGridContainer
extends GridContainer

#region Parameters
@export var popLabelScene: PackedScene = preload("res://Game/2048/UI/PopLabel.tscn")
@export var gameOverScene: PackedScene = preload("res://Game/2048/UI/GameOverContainer.tscn")
#endregion


#region Consts

#endregion


#region State
var slots: Array[int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var lastSlots: Array[int] = []
var rows: Array[Array] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
var cols: Array[Array] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
var remainingSlots: Array = range(16)
#endregion


#region Signals

#endregion


#region Dependencies
@onready var scoreLabel: Label = %ScoreLabel
@onready var uiEx: CanvasLayer = %UI_EX

#endregion


#region Lifecycles

func _ready() -> void:
	for i:int in 2:
		createSlotScore()
	
	updateGameScore()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if canMove():
			if event.is_action_pressed("moveLeft"): moveRows()
			if event.is_action_pressed("moveRight"): moveRows(true)
			if event.is_action_pressed("moveUp"): moveCols()
			if event.is_action_pressed("moveDown"): moveCols(true)
		else:
			createPopLabel("当前方向无法移动！")

#endregion


#region GetAndSets


#endregion


#region Tools

func createPopLabel(_str: String) -> void:
	var popLabel: PopLabel = popLabelScene.instantiate()
	popLabel.text = _str
	uiEx.add_child(popLabel)


func saveLastSlots() -> void:
	lastSlots = []
	for i: int in slots: lastSlots.append(i)


func undoSlotsMove() -> void:
	if lastSlots.is_empty(): 
		createPopLabel("无法撤回！")
		return
	slots = lastSlots
	updateSlotsScore()
	updateRemainingSlots()
	updateGameScore()
	lastSlots = []


func mergeSlots(arrs: Array, isReverse: bool = false) -> void:
	for arr in arrs.size():
		var arrSize: int = arrs[arr].size()
		if isReverse:
			for i: int in range(arrSize - 1, 0, -1):
				if arrs[arr][i] == arrs[arr][i - 1] and arrs[arr][i] != 0:
					arrs[arr][i] *= 2
					arrs[arr][i - 1] = 0
		else:
			for i: int in arrSize - 1:
				if arrs[arr][i] == arrs[arr][i + 1] and arrs[arr][i] != 0:
					arrs[arr][i] *= 2
					arrs[arr][i + 1] = 0


func updateRemainingSlots() -> void:
	remainingSlots = []
	for i: int in slots.size():
		if slots[i] == 0: remainingSlots.append(i)


func canMove() -> bool:
	if slots.has(0): 
		return true
	else:
		if canMoveRows() or canMoveCols():
			return true
	return false


## 能否水平移动
func canMoveRows() -> bool:
	for i: int in rows.size():
		for j: int in rows[i].size() - 1:
			if rows[i][j] == rows[i][j + 1]:
				return true
	return false


## 能否垂直移动
func canMoveCols() -> bool:
	for i: int in cols.size():
		for j: int in cols[i].size() - 1:
			if cols[i][j] == cols[i][j + 1]:
				return true
	return false


func moveRows(isReverse: bool = false) -> void:
	saveLastSlots()
	move(rows, isReverse)
	mergeSlots(rows, isReverse)
	move(rows, isReverse)
	updateSlotsByRows()
	updateRemainingSlots()
	createSlotScore()
	updateGameScore()


func moveCols(isReverse: bool = false) -> void:
	saveLastSlots()
	move(cols, isReverse)
	mergeSlots(cols, isReverse)
	move(cols, isReverse)
	updateSlotsByCols()
	updateRemainingSlots()
	createSlotScore()
	updateGameScore()


func move(arrs: Array, isReverse: bool = false) -> void:
	if isReverse:
		for arr: int in arrs.size():
			var right: int = arrs[arr].size() - 1
			for left: int in range(arrs[arr].size()-1, -1, -1):
				if arrs[arr][left] == 0: continue
				var temp: int = arrs[arr][left]
				arrs[arr][left] = arrs[arr][right]
				arrs[arr][right] = temp
				right -= 1
		return
	for arr: int in arrs.size():
		var left: int = 0
		for right: int in arrs[arr].size():
			if arrs[arr][right] == 0: continue
			var temp: int = arrs[arr][right]
			arrs[arr][right] = arrs[arr][left]
			arrs[arr][left] = temp
			left += 1


func restartGame() -> void:
	slots = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	remainingSlots = range(16)
	_ready()


func updateGameScore() -> void:
	var score: int = 0
	for i: int in slots:
		score += i
	scoreLabel.text = "游戏分数：%s" % score
	if not canMove():
		var gameOver: GameOverContainer = gameOverScene.instantiate()
		gameOver.score = score
		Tools.connectSignal(gameOver.gameOver, restartGame)
		uiEx.add_child(gameOver)


func updateRows() -> void:
	for i: int in slots.size(): 
		var rowIndex: int = floori(i/4.0)
		rows[rowIndex][i%4] = slots[i]


func updateSlotsByRows() -> void:
	for i: int in rows.size():
		for j: int in rows[i].size():
			slots[i*4 + j] = rows[i][j]


func updateCols() -> void:
	for i: int in slots.size(): 
		var colIndex: int = floori(i/4.0)
		cols[i%4][colIndex] = slots[i]


func updateSlotsByCols() -> void:
	for i: int in cols.size():
		for j: int in cols[i].size():
			slots[j*4 + i] = cols[i][j]


func updateSlotsScore() -> void:
	for i in get_child_count():
		var slot: Slot = get_child(i)
		slot.score = slots[i]
	
	updateRows()
	updateCols()


func createSlotScore(_score: int = -1) -> void:
	var score: int = _score
	if score == -1: score = 2 if randi() % 100 < 90 else 4
	if remainingSlots.size() > 0:
		var randSlotIndex: int = remainingSlots.pop_at(randi() % remainingSlots.size())
		slots[randSlotIndex] = score
		
		updateSlotsScore()

#endregion
