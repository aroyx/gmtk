extends CharacterBody2D
class_name Player

var nearby_bush = null
var is_hidden = false

@export var speed = 250.0
var screen_size: Vector2
var player_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	var rad = $CollisionShape2D.shape.radius
	player_size = Vector2(rad, rad)

var facing_dir = "fwd"
@onready var marker = $TextBubbleMarker

var lines: Array[String] = [
	"Hey! Are you a nice person?",
	"Because I am a really nice person!",
	"Actually, ik we just met eachother....",
	"but the thing is.....",
	"I LOVE YOU!! <insert_heart_emoji>"
]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start_timer"):
		$TimerCircleSimple.start_countdown(9)
	
	if event.is_action_pressed("hide"):
		if !is_hidden && nearby_bush != null && nearby_bush.hide_ready:
			hide_player()
		elif is_hidden:
			unhide_player()
	if event.is_action_pressed("interact"):
		DialogueManager.start_dialog(marker.global_position, lines, self)

func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		input_dir.y += 1
	
	if Input.is_action_pressed("move_up"):
		input_dir.y -= 1
		
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
		
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	
	velocity = input_dir.normalized() * speed
	move_and_slide()
	# Remove this when our plan is to expand the map beyond the screen size
	position = position.clamp(Vector2.ZERO + player_size, screen_size - player_size)
	
	# Animations
	if input_dir.x > 0:
		facing_dir = "right"
	elif input_dir.x < 0:
		facing_dir = "left"
	elif input_dir.y > 0:
		facing_dir = "fwd"
	elif input_dir.y < 0:
		facing_dir = "back"
	
	if input_dir == Vector2.ZERO:
		$AnimatedSprite2D.play("idle_" + facing_dir)
	else:
		$AnimatedSprite2D.play("walk_" + facing_dir)

func hide_player() -> void:
	is_hidden = true
	visible = false
	set_physics_process(false)
	if nearby_bush != null:
		nearby_bush.player_hiding = true

func unhide_player():
	is_hidden = false
	visible = true
	set_physics_process(true)
	if nearby_bush != null:
		nearby_bush.player_hiding = false
