class_name Interactable
extends RigidBody3D


@onready var creak_1: AudioStreamPlayer3D = $Creak1
@onready var creak_2: AudioStreamPlayer3D = $Creak2
@onready var audio_timer: Timer = $AudioTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var vectorPos : Vector2 = Vector2(global_position.x, global_position.z)

@export_range(0.0, 60.0, 1.0) var sinkTime : int

var boatInRange: bool = false
var hasInteracted : bool = false


func _ready() -> void:
	SignalBus.connect("interact", interact)
	
	#TEMP
	SignalBus.emit_signal("emitBoatCoordinate", Vector2(position.x, position.z))


func _process(_delta: float) -> void:
	if boatInRange and audio_timer.is_stopped():
		audio_timer.start()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not rowboat:
		return
	
	boatInRange = true
	animation_player.play("sink")
	
	await animation_player.animation_finished
	queue_free()


func interact():
	if boatInRange and !hasInteracted:
		hasInteracted = true
		
		SignalBus.emit_signal("addPreserver")
		SignalBus.emit_signal("popBoatCoord", vectorPos)


func _on_audio_timer_timeout() -> void:
	match randi_range(1, 2):
		1:
			creak_1.play()
		2:
			creak_2.play()
