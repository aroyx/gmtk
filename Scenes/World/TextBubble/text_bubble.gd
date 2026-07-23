extends PanelContainer

@onready var label = $Label
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 500

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String) -> void:
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
