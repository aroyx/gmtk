extends CharacterBody2D

@export var step_size: float = 100.0
@export var move_speed: float = 150.0

var screen_size: Vector2
var player_size: Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var ray_cast_up: ShapeCast2D = $RayCastUp
@onready var ray_cast_down: ShapeCast2D = $RayCastDown
@onready var ray_cast_right: ShapeCast2D = $RayCastRight
@onready var ray_cast_left: ShapeCast2D = $RayCastLeft

@onready var timer: Timer = $Timer

#@onready var color_rect_1: ColorRect = $RayCastRight/ColorRect
#@onready var color_rect_2: ColorRect = $RayCastLeft/ColorRect
#@onready var color_rect_3: ColorRect = $RayCastUp/ColorRect2
#@onready var color_rect_4: ColorRect = $RayCastDown/ColorRect3

# For dialog
@onready var text_box_scene = preload("res://Scenes/World/TextBubble/TextBubble.tscn")
@onready var marker = $Marker2D

var curr_bubble: Node = null

const texts: Array[String] = [
	"Burp",
	"Fart",
	"17 + 13 equals 20",
	"352 power 3 equals 43614208",
	"this is so lame",
	"I hope it rains tomorrow",
	"ts pmo",
	"who you tryna rizz gng",
	"67",
	"67 my ahh",
]

var DIRECTIONS: Dictionary
var RAYCASTS: Dictionary
#var COLOR_RECTS: Dictionary

const MAX_TIME := 8.0

var target_position: Vector2
var is_moving: bool = false

const colors : Array[Color] = [
	Color.DARK_RED, Color.FIREBRICK, Color.ORANGE_RED, Color.TOMATO,
	Color.INDIAN_RED, Color.PERU, Color.SILVER, Color.GOLD,
	Color.SPRING_GREEN, Color.CYAN, Color.DODGER_BLUE, Color.DARK_TURQUOISE,
	Color.DEEP_PINK, Color.CRIMSON, Color.HOT_PINK, Color.INDIGO,  Color.BLUE_VIOLET,
	Color.MEDIUM_SLATE_BLUE, Color.AQUAMARINE
]

func _ready() -> void:
	screen_size = get_viewport_rect().size
	var rad = $CollisionShape2D.shape.radius
	player_size = Vector2(rad, rad)

	DIRECTIONS = {
		"up": Vector2.UP,
		"down": Vector2.DOWN,
		"left": Vector2.LEFT,
		"right": Vector2.RIGHT,
	}
	RAYCASTS = {
		"up": ray_cast_up,
		"down": ray_cast_down,
		"left": ray_cast_left,
		"right": ray_cast_right,
	}
	#COLOR_RECTS = {
		#"up": color_rect_3,
		#"down": color_rect_4,
		#"left": color_rect_2,
		#"right": color_rect_1,
	#}
	_on_timer_timeout()
	set_random_timer()
	
	$AnimatedSprite2D.material = $AnimatedSprite2D.material.duplicate()
	$AnimatedSprite2D.material.set_shader_parameter("new_color", colors.pick_random())
	
	call_deferred("random_text_time")

var first_time = true
func random_text_time():
	if first_time:
		$TextTimer.start(randf_range(2, 20))
		first_time = false
	else:
		$TextTimer.start(randf_range(10, 20))

func _physics_process(_delta: float) -> void:
	if is_moving:
		var to_target = target_position - global_position
		if to_target.length() <= 4.0:
			global_position = target_position
			velocity = Vector2.ZERO
			is_moving = false
			animated_sprite_2d.play("idle_fwd")
		else:
			velocity = to_target.normalized() * move_speed
			move_and_slide()
			
			if get_slide_collision_count() > 0:
				is_moving = false
				velocity = Vector2.ZERO
				animated_sprite_2d.play("idle_fwd")
	else:
		velocity = Vector2.ZERO


func walk_randomly() -> void:
	if is_moving:
		return

	var dirs = DIRECTIONS.keys()
	dirs.shuffle()

	for dir in dirs:
		if try_direction(dir):
			return


func try_direction(dir: String) -> bool:
	var ray_cast: ShapeCast2D = RAYCASTS[dir]

	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider(0)

		if collider.is_in_group("player"):
			print("game over")
		return false

	start_move(dir)
	return true


func start_move(dir: String) -> void:
	var dir_vector: Vector2 = DIRECTIONS[dir]
	var step_size_random = randf_range(step_size * 0.5, step_size * 2)
	target_position = global_position + dir_vector * step_size_random
	is_moving = true

	update_animation(dir_vector)
	#make_ShapeCast_visible(COLOR_RECTS[dir])


func update_animation(dir: Vector2) -> void:
	if dir.length() < 0.1:
		animated_sprite_2d.play("idle_fwd")
		return

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			animated_sprite_2d.play("walk_right")
		else:
			animated_sprite_2d.play("walk_left")
	else:
		if dir.y > 0:
			animated_sprite_2d.play("walk_fwd")
		else:
			animated_sprite_2d.play("walk_back")


#func make_ShapeCast_visible(current_shapeCast: ColorRect) -> void:
	#color_rect_1.visible = false
	#color_rect_2.visible = false
	#color_rect_3.visible = false
	#color_rect_4.visible = false
#
	#current_shapeCast.visible = true

func set_random_timer() -> void:
	var rand_time = [2, 3, 4].pick_random()
	timer.wait_time = rand_time
	timer.start()

func _on_timer_timeout() -> void:
	walk_randomly()
	set_random_timer()

func say_random_thing():
	if is_instance_valid(curr_bubble):
		return
	
	curr_bubble = text_box_scene.instantiate()
	
	get_tree().root.add_child(curr_bubble)
	
	curr_bubble.display_text_no_sound(texts.pick_random(), self)
	
	await get_tree().create_timer(5).timeout
	if is_instance_valid(curr_bubble):
		curr_bubble.queue_free()

func _on_text_timer_timeout() -> void:
	say_random_thing()
	random_text_time()
