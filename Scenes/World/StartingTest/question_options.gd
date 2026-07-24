extends MarginContainer

signal option_pressed(option)


func set_no_wrap():
	$Label.custom_minimum_size.x = 1000

func set_text(text: String):
	$Label.text = text # using `label` doesn't work here

func set_tick_visible(yes: bool = true):
	$Sprite2D.visible = yes

func _on_button_pressed() -> void:
	option_pressed.emit(self)
	UiSound.play_sound_click()
	print("yay:" + $Label.text)
