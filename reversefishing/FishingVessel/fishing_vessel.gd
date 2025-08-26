class_name Interactable
extends StaticBody3D

@export_range(0.0, 60.0, 1.0) var sinkTime : int

var sinkingTween : Tween
var boatInRange: bool = false
var hasInteracted : bool = false

func _ready() -> void:
	SignalBus.connect("interact", interact)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not rowboat:
		return
	
	boatInRange = true
	sinkingTween = get_tree().create_tween()
	sinkingTween.tween_property(self, "position", Vector3(position.x, -2, position.z), sinkTime)
	
	await sinkingTween.finished
	queue_free()


func interact():
	if boatInRange and !hasInteracted:
		hasInteracted = true
		
		sinkingTween.set_speed_scale(5)
		SignalBus.emit_signal("addPreserver")
