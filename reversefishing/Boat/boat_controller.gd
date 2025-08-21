class_name rowboat
extends CharacterBody3D

@export var baseBoatSpeed : float = 1

@onready var head: Node3D = $Head
@onready var camera_3d: Camera3D = $Head/Camera3D
@onready var preserver_marker: Marker3D = $PreserverMarker

var preserver : PackedScene = preload("res://Life Preserver/life_preserver.tscn")
var preserverArray : Array[LifePreserver] = []

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


func _process(delta: float) -> void:
	forwardVector = -global_transform.basis.z
	timeElpased += delta
	varBoatSpeed = amplitude * sin(frequency * timeElpased) + sinOffset
	
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		
		turnDirection = Input.get_axis("Left", "Right")
		rotation_degrees.y = lerp(rotation_degrees.y,rotation_degrees.y + (-varBoatSpeed * 3 * turnDirection), exp(-500 * delta))
		velocity = lerp(velocity, (forwardVector * (varBoatSpeed + baseBoatSpeed)), exp(-500 * delta))
	else:
		velocity = lerp(velocity, Vector3.ZERO, exp(-1000 * delta))
	
	if Input.is_action_just_pressed("Interact"):
		SignalBus.emit_signal("interact")
	
	move_and_slide()


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
	else:
		preserverArray.get(preserverArray.size() - 1).getMarker().add_child(newPreserver)
	
	preserverArray.append(newPreserver)
