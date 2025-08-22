extends Node3D

@onready var joint_5: PinJoint3D = $Joints/Joint5
@onready var life_preserver: LifePreserver = $"Life Preserver"
@onready var connection_marker: Marker3D = %ConnectionMarker


func setRopeAttachment(attachPoint) -> void:
	joint_5.node_b = attachPoint.get_path()


func getMarker() -> Marker3D:
	return connection_marker


func getLifePreserver() -> LifePreserver:
	return life_preserver
