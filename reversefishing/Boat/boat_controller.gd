class_name rowboat
extends CharacterBody3D

@export var baseBoatSpeed : float = 1

@onready var head: Node3D = $Head
@onready var camera_3d: Camera3D = $Head/Camera3D
@onready var preserver_marker: Marker3D = $PreserverMarker
@onready var rope_attach_point: StaticBody3D = $RopeAttachPoint

var preserver : PackedScene = preload("res://Rope/rope.tscn")
var preserverArray : Array[Node3D] = []

var mouseSensitivity : int = 1

var rotationTween : Tween
var canRotate : bool = true

var forwardVector : Vector3
var turnDirection : float
var varBoatSpeed : float

var amplitude = 0.7
var frequency = 2
var sinOffset = 1

var timeElpased : float = 0.0


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	SignalBus.connect("addPreserver", createPreserver)
	SignalBus.connect("eatThatGuy", getEatedIdiot)
	SignalBus.connect("callEatToHappen", uhhEatCall)


func _process(delta: float) -> void:
	forwardVector = -global_transform.basis.z
	timeElpased += delta
	varBoatSpeed = amplitude * sin(frequency * timeElpased) + sinOffset
	
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		velocity = lerp(velocity, (forwardVector * (varBoatSpeed + baseBoatSpeed)), delta)
		
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		turnDirection = Input.get_axis("Left", "Right")
		rotation_degrees.y = lerp(rotation_degrees.y,rotation_degrees.y + (-varBoatSpeed * 3 * turnDirection), delta * 8)
		velocity = lerp(velocity, (forwardVector * ((varBoatSpeed + baseBoatSpeed) / 3)), delta)
	else:
		velocity = lerp(velocity, Vector3.ZERO, delta)
	
	if Input.is_action_just_pressed("Interact"):
		SignalBus.emit_signal("interact")
	
	
	if Input.is_action_just_pressed("Escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	
	if !is_on_floor():
		velocity.y = -9.8
	
	
	move_and_slide()
	sendCurrentCoordinates()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x / 1000 * mouseSensitivity)
		camera_3d.rotate_x(event.relative.y / 1000 * mouseSensitivity)
		head.rotation_degrees.y = clamp(head.rotation_degrees.y, -120, 120)
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -65, 65)


func createPreserver():
	var newPreserver = preserver.instantiate()
	if preserverArray == []:
		preserver_marker.add_child(newPreserver)
		newPreserver.setRopeAttachment(rope_attach_point)
		newPreserver.top_level = true
	else:
		get_tree().current_scene.add_child(newPreserver)
		newPreserver.reparent(preserverArray.get(preserverArray.size() - 1).getMarker(), false)
		newPreserver.setRopeAttachment(preserverArray.get(preserverArray.size() - 1).getLifePreserver())
		newPreserver.top_level = true
	
	preserverArray.append(newPreserver)


func sendCurrentCoordinates():
	SignalBus.emit_signal("sendRowboatCoordinate", Vector2(global_position.x, global_position.z,))


func getEatedIdiot():
	if !preserverArray.is_empty():
		preserverArray.get(preserverArray.size() - 1).queue_free()
		preserverArray.pop_back()
	else:
		await get_tree().create_timer(0.3).timeout
		get_tree().reload_current_scene()


func uhhEatCall():
	if !preserverArray.is_empty():
		SignalBus.emit_signal("spawnMonster", preserverArray.get(preserverArray.size() - 1).getLifePreserver())
	else:
		SignalBus.emit_signal("spawnMonster", self)
