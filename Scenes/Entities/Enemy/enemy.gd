extends CharacterBody2D

@export var step_size = 100.0
var screen_size: Vector2
var player_size: Vector2

# RayCast2D Components
@onready var ray_cast_up: ShapeCast2D = $RayCastUp
@onready var ray_cast_down: ShapeCast2D = $RayCastDown
@onready var ray_cast_right: ShapeCast2D = $RayCastRight
@onready var ray_cast_left: ShapeCast2D = $RayCastLeft

@onready var timer: Timer = $Timer

@onready var color_rect_1: ColorRect = $RayCastRight/ColorRect
@onready var color_rect_2: ColorRect = $RayCastLeft/ColorRect
@onready var color_rect_3: ColorRect = $RayCastUp/ColorRect2
@onready var color_rect_4: ColorRect = $RayCastDown/ColorRect3


func _ready() -> void:
	screen_size = get_viewport_rect().size
	var rad = $CollisionShape2D.shape.radius
	player_size = Vector2(rad, rad)

func _physics_process(delta: float) -> void:
	
	#var rand = [1,2,3,4].pick_random();
	#
	#check_raycast(ray_cast_up, "up")
	#check_raycast(ray_cast_down, "down")
	#check_raycast(ray_cast_left, "left")
	#check_raycast(ray_cast_right, "right")
	
	
	#if ray_cast_up.is_colliding():
		#var collider = ray_cast_up.get_collider()
		#
		#print("colliding_obj with RayCastUP:  ",collider)
		#
		#if collider and collider.is_in_group("tempObject"):
			#print("collider in the group tempObject :: ", collider)
	#
	#if ray_cast_down.is_colliding():
		#var collider = ray_cast_down.get_collider()
		#
		#print("colliding_obj with RayCastDown:  ",collider)
		#
		#if collider and collider.is_in_group("tempObject"):
			#print("collider in the group tempObject :: ", collider)
	#
	#if ray_cast_left.is_colliding():
		#var collider = ray_cast_left.get_collider()
		#
		#print("colliding_obj with RayCastLeft:  ",collider)
		#if collider and collider.is_in_group("tempObject"):
			#print("collider in the group tempObject :: ", collider)
	#
	#
	#if ray_cast_right.is_colliding():
		#var collider = ray_cast_right.get_collider()
		#
		#print("colliding_obj with RayCastRight:  ",collider)
		#
		#if collider and collider.is_in_group("tempObject"):
			#print("collider in the group tempObject :: ", collider)
	#
	
	var input_dir = Vector2.ZERO
	
	print(floor(timer.time_left))
	
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
	
	#position += input_dir.normalized() * step_size * delta * speed_multiplier
	# Remove this when our plan is to expand the map beyond the screen size
	position = position.clamp(Vector2.ZERO + player_size, screen_size - player_size)
	
	# Animations
	#if input_dir.x == 0 && input_dir.y == 0:
		#$AnimatedSprite2D.play("idle")
	#elif Input.is_action_pressed("player_run"):
		#$AnimatedSprite2D.play("run")
	#else:
		#$AnimatedSprite2D.play("walk")

	#if input_dir != Vector2.ZERO:
		#var rot = input_dir.angle()
		#rotation = lerp_angle(rotation, rot, 10 * delta)

func walk_randomly():
	var random_number = [1,2,3,4].pick_random()
	
	if random_number == 1:
		check_raycast(ray_cast_up, "up")
	elif  random_number == 2:
		check_raycast(ray_cast_down, "down")
	elif  random_number == 3:
		check_raycast(ray_cast_left, "left")
	elif  random_number == 4:
		check_raycast(ray_cast_right, "right")

func check_raycast(ray_cast: ShapeCast2D, dir: String):
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider(0)
		
		print("colliding_obj at ",dir, "  ", collider)
		
		if collider.is_in_group("world_object"):
			print("a world object detected here.")
			walk_randomly()
		elif collider.is_in_group("player"):
			print("game over")
	else: 
		if dir == "up":
			print("walked  ", dir)
			position += Vector2(0,-step_size)
			make_ShapeCast_visible(color_rect_3)
		elif dir == "down":
			print("walked  ", dir)
			position +=  Vector2(0, step_size)
			make_ShapeCast_visible(color_rect_4)
		elif dir == "left":
			print("walked  ", dir)
			position += Vector2(-step_size, 0)
			make_ShapeCast_visible(color_rect_2)
		elif dir == "right":
			print("walked  ", dir)
			position += Vector2(step_size, 0)
			make_ShapeCast_visible(color_rect_1)

func make_ShapeCast_visible(current_shapeCast: ColorRect):
	color_rect_1.visible = false
	color_rect_2.visible = false
	color_rect_3.visible = false
	color_rect_4.visible = false
	
	current_shapeCast.visible = true

func set_random_timer():
	var rand_time = [2,3,4].pick_random()
	timer.wait_time = rand_time;
	timer.start();

func _on_timer_timeout() -> void:
	walk_randomly()
	set_random_timer()
