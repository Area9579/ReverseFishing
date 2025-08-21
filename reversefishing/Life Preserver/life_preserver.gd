class_name LifePreserver
extends RigidBody3D

@onready var connection_marker: Marker3D = $ConnectionMarker


func getMarker() -> Marker3D:
	return connection_marker
