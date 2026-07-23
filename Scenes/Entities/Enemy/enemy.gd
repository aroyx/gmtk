extends CharacterBody2D

@export var speed = 250.0
var screen_size: Vector2
var player_size: Vector2

# RayCast2D Components
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

@onready var timer: Timer = $Timer

func _ready() -> void:
	screen_size = get_viewport_rect().size
	var rad = $CollisionShape2D.shape.radius
	player_size = Vector2(rad, rad)

#func set_random_timer():
	#var rand_time = [5,6,10,7,9].pick_random()
	#timer.wait_time = rand_time;
	#timer.start();
#


func _physics_process(delta: float) -> void:
	
	#var rand = [1,2,3,4].pick_random();
	
	if ray_cast_up.is_colliding():
		var collider = ray_cast_up.get_collider()
		
		print("colliding_obj with RayCastUP:  ",collider)
		
		if collider and collider.is_in_group("tempObject"):
			print("collider in the group tempObject :: ", collider)
	
	if ray_cast_down.is_colliding():
		var collider = ray_cast_down.get_collider()
		
		print("colliding_obj with RayCastDown:  ",collider)
		
		if collider and collider.is_in_group("tempObject"):
			print("collider in the group tempObject :: ", collider)
	
	if ray_cast_left.is_colliding():
		var collider = ray_cast_left.get_collider()
		
		print("colliding_obj with RayCastLeft:  ",collider)
		
		if collider and collider.is_in_group("tempObject"):
			print("collider in the group tempObject :: ", collider)
	
		
	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		
		print("colliding_obj with RayCastRight:  ",collider)
		
		if collider and collider.is_in_group("tempObject"):
			print("collider in the group tempObject :: ", collider)
	
	
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
	
	velocity += input_dir.normalized() * speed * delta * speed_multiplier
	move_and_slide()
	# Remove this when our plan is to expand the map beyond the screen size
	position = position.clamp(Vector2.ZERO + player_size, screen_size - player_size)
	
	# Animations
	#if input_dir.x == 0 && input_dir.y == 0:
		#$AnimatedSprite2D.play("idle")
	#elif Input.is_action_pressed("player_run"):
		#$AnimatedSprite2D.play("run")
	#else:
		#$AnimatedSprite2D.play("walk")

	if input_dir != Vector2.ZERO:
		var rot = input_dir.angle()
		rotation = lerp_angle(rotation, rot, 10 * delta)




#
#func _on_timer_timeout() -> void:
	#set_random_timer()
