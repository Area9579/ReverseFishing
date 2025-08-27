extends RigidBody3D

@export var float_force : float = 0.015
@export var linear_water_drag : float = 1.4
@export var angular_water_drag : float = 1.4

@onready var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var water: MeshInstance3D = %Water
@onready var probes: Array[Node] = $Probes.get_children() # dude this line looks so chopped but it works???

var submerged : bool = false
var depth : float

func _ready() -> void:
	float_force /= probes.size()
	print(float_force)

func _physics_process(delta: float) -> void:
	submerged = false
	
	for p in probes:
		depth = water.get_height(p.global_position) - p.global_position.y
		if depth > 0:
			apply_force(Vector3.UP * float_force * gravity, p.global_position - global_position)
			submerged = true
	
	
	
	#var depth = water.get_height(global_position) - global_position.y
	#if depth > 0:
		#apply_central_force(Vector3.UP * float_force * gravity * depth)
		#submerged = true
	#else:
		#submerged = false

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	#return
	if submerged:
		state.linear_velocity *= 1 - linear_water_drag
		state.angular_velocity *= 1 - angular_water_drag
	
