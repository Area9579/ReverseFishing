extends MeshInstance3D

var material : ShaderMaterial 
var noise : Image

var noise_scale : float
var wave_speed : float
var height_scale : float

var amount : float
var time : float
#
#func _ready() -> void:
	#amount = material.get_shader_parameter("amount")
#
#func _process(delta: float) -> void:
	#time += delta
	#material.set_shader_parameter("wave_time", time)
#
#func get_height(world_position: Vector3) -> float:
	#var uv_world_position = applyDistortion(world_position, time)
	#var uv_x = wrapf(uv_world_position.x, 0, 1)
	#var uv_y = wrapf(uv_world_position.z, 0, 1)
	#return 0.0
#
#func generateOffset(x : float, z: float, val1: float, val2: float, time: float):
	#var speed : float = 0.6;
	#var radiansX = material.get_shader_parameter("radiansX")
	#var radiansZ = material.get_shader_parameter("radiansY")
	##var radiansX : float = (( mod(x + z * x * val1, amount) / amount ) + (time * speed) * mod(x * 0.8 + z, 1.5)) * 2.0 * 3.14
	##var radiansZ : float = (( mod(val2 * (z * x + x * z), amount) / amount) + (time * speed) * 2.0 * mod(x, 2.0)) * 2.0 * 3.14
	#
	#return amount * 0.5 * (sin(radiansZ) + cos(radiansX))
#
#
#func applyDistortion(vertex : Vector3, time : float):
	#var xd : float = generateOffset(vertex.x, vertex.z, 0.2, 0.1, time)
	#var yd : float = generateOffset(vertex.x, vertex.z, 0.1, 0.3, time)
	#var zd : float = generateOffset(vertex.x, vertex.z, 0.15, 0.2, time)
	#return vertex + Vector3(xd, yd, zd)
#
##func mod(a : float, b : float):
	##var c = a % b
	##pass
