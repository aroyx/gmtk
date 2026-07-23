extends Node2D

@export var color = Color.AQUA

var time_left = 2.0
var init_roation: float = 0

func start_countdown(time: float) -> void:
	$Timer.start(time)

func _ready() -> void:
	init_roation = global_rotation
	$ColorRect.material = $ColorRect.material.duplicate()
	$ColorRect.material.set_shader_parameter("color", color)
	$ColorRect.material.set_shader_parameter("val", 0.0)

func _process(delta: float) -> void:
	global_rotation = init_roation
	
	if $Timer.is_stopped():
		$ColorRect.material.set_shader_parameter("val", 0.0)
	else:
		$ColorRect.material.set_shader_parameter("val", $Timer.time_left / $Timer.wait_time)

	
