extends Node3D

@onready var timer: Timer = $Timer
@onready var _0: AudioStreamPlayer = $"0"
@onready var _1: AudioStreamPlayer = $"1"
@onready var _2: AudioStreamPlayer = $"2"
@onready var _3: AudioStreamPlayer = $"3"
@onready var _4: AudioStreamPlayer = $"4"
@onready var _5: AudioStreamPlayer = $"5"
@onready var _6: AudioStreamPlayer = $"6"
@onready var _7: AudioStreamPlayer = $"7"
@onready var _8: AudioStreamPlayer = $"8"
@onready var _9: AudioStreamPlayer = $"9"
@onready var __: AudioStreamPlayer = $"-"
@onready var x: AudioStreamPlayer = $X
@onready var y: AudioStreamPlayer = $Y


var coordinateArray : Array[Vector2i]


func _ready() -> void:
	SignalBus.connect("emitBoatCoordinate", enterCoords)
	SignalBus.connect("popBoatCoord", popList)
	
	await get_tree().create_timer(5).timeout
	playCoordinates()


func enterCoords(coordinates : Vector2):
	coordinateArray.append(Vector2i(snappedi(coordinates.x, 1), snappedi(coordinates.y, 1)))

func playCoordinates():
	timer.start()
	
	if !coordinateArray.is_empty():
		x.play()
		await x.finished
		for num in range(0, str(coordinateArray[0].x).length()):
			match str(coordinateArray[0].x)[num]:
				"0":
					_0.play()
					await _0.finished
				"1":
					_1.play()
					await _1.finished
				"2":
					_2.play()
					await _2.finished
				"3":
					_3.play()
					await _3.finished
				"4":
					_4.play()
					await _4.finished
				"5":
					_5.play()
					await _5.finished
				"6":
					_6.play()
					await _6.finished
				"7":
					_7.play()
					await _7.finished
				"8":
					_8.play()
					await _8.finished
				"9":
					_9.play()
					await _9.finished
				"-":
					__.play()
					await __.finished
		
		await get_tree().create_timer(0.2).timeout
		y.play()
		await y.finished
		for num in range(0, str(coordinateArray[0].y).length()):
			match str(coordinateArray[0].y)[num]:
				"0":
					_0.play()
					await _0.finished
				"1":
					_1.play()
					await _1.finished
				"2":
					_2.play()
					await _2.finished
				"3":
					_3.play()
					await _3.finished
				"4":
					_4.play()
					await _4.finished
				"5":
					_5.play()
					await _5.finished
				"6":
					_6.play()
					await _6.finished
				"7":
					_7.play()
					await _7.finished
				"8":
					_8.play()
					await _8.finished
				"9":
					_9.play()
					await _9.finished
				"-":
					__.play()
					await __.finished


func _on_timer_timeout() -> void:
	playCoordinates()


func popList(coordin : Vector2):
	if coordinateArray.size() == 1:
		coordinateArray.remove_at(0)
	
	if !coordinateArray.is_empty():
		for coordPos in range(0, coordinateArray.size() - 1):
			if coordinateArray[coordPos] == Vector2i(snappedi(coordin.x, 1), snappedi(coordin.y, 1)):
				coordinateArray.remove_at(coordPos)
