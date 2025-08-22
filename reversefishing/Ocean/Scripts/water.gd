extends MeshInstance3D
class_name Water

var material : ShaderMaterial
var noise : Image

var noise_scale : float
var time_scale : float
var height_scale : float

var time : float

func _ready() -> void:
	material = get_surface_override_material(0)
	noise = material.get_shader_parameter("wave").noise.get_seamless_image(512, 512)
	noise_scale = material.get_shader_parameter("noise_scale")
	height_scale = material.get_shader_parameter("height_scale")
	time_scale = material.get_shader_parameter("time_scale")
	

func _process(delta: float) -> void:
	set_new_time.call_deferred(delta)
	#time += delta
	#material.set_shader_parameter("wave_time", time)

func set_new_time(delta : float):
	time += delta
	material.set_shader_parameter("wave_time", time)

func get_height(world_position : Vector3) -> float:
	var uv_x = wrapf(world_position.x / noise_scale + time * time_scale, 0, 1)
	var uv_y = wrapf(world_position.z / noise_scale + time * time_scale, 0, 1)
	
	var pixel_pos = Vector2(uv_x * noise.get_width(), uv_y * noise.get_height())
	
	return global_position.y + noise.get_pixelv(pixel_pos).r * height_scale
