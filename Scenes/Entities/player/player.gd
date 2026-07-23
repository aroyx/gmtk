extends CharacterBody2D

@export var speed = 250.0
var screen_size: Vector2
var player_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	var rad = $CollisionShape2D.shape.radius
	player_size = Vector2(rad, rad)

func _process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		input_dir.y += 1
	
	if Input.is_action_pressed("move_up"):
		input_dir.y -= 1
		
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
		
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	
	var speed_multiplier = 1
	if Input.is_action_pressed("player_run"):
		speed_multiplier = 1.5
		# This is for prototyping, remove later together with the else block
		$AnimatedSprite2D.modulate = Color.GREEN
	else:
		$AnimatedSprite2D.modulate = Color.WHITE

	
	position += input_dir.normalized() * speed * delta * speed_multiplier
	
	# Remove this when our plan is to expand the map beyond the screen size
	position = position.clamp(Vector2.ZERO + player_size, screen_size - player_size)
	
	# Animations
	if input_dir.x == 0 && input_dir.y == 0:
		$AnimatedSprite2D.play("idle")
	elif Input.is_action_pressed("player_run"):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("walk")

	if input_dir != Vector2.ZERO:
		var rot = input_dir.angle()
		rotation = lerp_angle(rotation, rot, 10 * delta)

	if Input.is_action_just_pressed("start_timer"):
		$TimerCircle.start_countdown(randf_range(0, 7))
