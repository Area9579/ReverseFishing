extends CanvasLayer

@onready var player_coords: Label = $PlayerCoords


func _ready() -> void:
	SignalBus.connect("sendRowboatCoordinate", updateRowboatCoordinates)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Map"):
		swapVisibility()


func swapVisibility():
	match self.visible:
		true:
			hide()
		false:
			show()


func updateRowboatCoordinates(coords : Vector2):
	player_coords.text = "pos x = " + str(snapped(coords.x, 0.1)) + "\npos y = " + str(snapped(coords.y, 0.1))
