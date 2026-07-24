extends PanelContainer

@onready var label = $Label
@onready var timer = $LetterDisplayTimer
@onready var sprite = $Sprite2D

const MAX_WIDTH = 500

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var sayer

signal finished_displaying()

func display_text(text_to_display: String, node) -> void:
	UiSound.play_sound_click()

	sayer = node
	
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(MAX_WIDTH, size.x)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # wait for x resize
		await resized # wait for y resize
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2.0
	global_position.y -= size.y + 24.0
	
	label.text = ""
	_position_pointer_sprite() # points to the sayer
	_display_letter()


func _display_letter() -> void:
	label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ",", ".", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

func _on_letter_display_timer_timeout() -> void:
	_display_letter()

func _position_pointer_sprite() -> void:
	sprite.position = Vector2(size.x / 2, size.y)

func _process(delta: float) -> void:
	if is_instance_valid(sayer) and "marker" in sayer:
		var target_pos = sayer.marker.global_position
		target_pos.x -= size.x / 2.0
		target_pos.y -= size.y + 24.0
		global_position = target_pos
