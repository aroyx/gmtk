extends StaticBody2D

var hide_ready = false
var player_hiding

func _ready() -> void:
	start_hide_timer(randf_range(20, 40))

func _on_sensor_body_entered(body: Node2D) -> void:
	if body is Player:
		body.nearby_bush = self

func _on_sensor_body_exited(body: Node2D) -> void:
	if body is Player:
		if body.nearby_bush == self: 
			body.nearby_bush = null

func start_hide_timer(time: float):
	$Timer.start(time)
	$TimerCircleSimple.start_countdown(time)

func _on_timer_timeout() -> void:
	hide_ready = true

var time_passed: float = 0.0
func _process(delta: float) -> void:
	if !player_hiding:
		return
	
	time_passed += delta
	$Sprite2D.skew = sin(time_passed * 20.0) * 0.06
