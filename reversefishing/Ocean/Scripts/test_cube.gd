extends RigidBody3D

@export var float_force : float = 0.15
@export var linear_water_drag : float = 0.1
@export var angular_water_drag : float = 0.1

@onready var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var water: Water = $"../Water"

const water_height : float = 0.0

var submerged : bool = false

## re-used local variables for _physics_process(): (defining them here saves allocation time)
var depth : float

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	depth = water.get_height(global_position) - global_position.y
	if depth > 0:
		apply_central_force(Vector3.UP * float_force * gravity * depth)
		submerged = true
	else:
		submerged = false

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity *= 1 - linear_water_drag
		state.angular_velocity *= 1 - angular_water_drag
