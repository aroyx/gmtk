extends Node2D

var option_scene = preload("res://Scenes/World/StartingTest/QuestionOptions.tscn")

@onready var question = $UI/MarginContainer/VBoxContainer/Question 
@onready var options = $UI/MarginContainer/VBoxContainer/OptionsContainer

var questions = [
	{
		"question": "Which one of the following is two zero two four?",
		"options": ["2024", "0044", "2044", "0024"]
	}, {
		"question": "This is a long question to test the ui's abilities, is it good enough??",
		"options": [
			"This is a option that has nothing to do with god", 
			"What...? Where did god even come from", 
			"Don't ask, just answer",
			"OMG are you Indian democracy?"
		]
	}, {
		"question": "What do you want for dinner?",
		"options": [
			"Dinner at 10 in the morning...?", 
			"What exam am I giving...", 
			"lizard balls",
			"Andrew Tate"
		]
	}, {
		"question": "Will you still like me if I was a worm?",
		"options": [
			"Yes ofcourse baby!", 
			"What? No! Ewww", 
			"I like worms more",
			"Brup.. fart"
		]
	}, {
		"question": "how to correctly pronounce 'gif'?",
		"options": [
			"gif", 
			"jif!", 
			"c++ sucks",
			"supercalifragilisticexpialidocious"
		]
	}, {
		"question": "If kirby can inhale another kirby, what would happen if they inhaled each other at the same time?",
		"options": [
			"Isnt that just a kiss?", 
			"That’s actually what caused the Big Bang.", 
			"ask buddha",
			"._."
		]
	}, {
		"question": "Can Jesus microwave a burrito so hot that even he can't eat it?",
		"options": [
			"Yes", 
			"No", 
			"Probably",
			"Are you a simp son?"
		]
	}, {
		"question": "What is 3 and 3?",
		"options": [
			"9", 
			"6", 
			"33",
			"27"
		]
	}
]

func _ready() -> void:
	load_question()

var curr_question_index = 0

func load_question():
	if curr_question_index >= questions.size():
		return
	
	for child in options.get_children():
		options.remove_child(child)
		child.queue_free()
	
	var q = questions[curr_question_index]
	question.text = str(curr_question_index + 1) + ". " + q["question"]
	
	var max_chars = 0
	for opt in q["options"]:
		if opt.length() > max_chars:
			max_chars = opt.length()
	
	options.columns = 1 if max_chars > 20 else 2
	
	var i = 1
	for opt in q["options"]:
		var new_opt = option_scene.instantiate()
		
		if options.columns == 1:
			new_opt.set_no_wrap()
		
		new_opt.set_text(char(i + 96) + ". " + opt)
		
		i += 1
		options.add_child(new_opt)
		new_opt.option_pressed.connect(on_option_clicked)
	
	curr_question_index += 1

var option_selected = false

func on_option_clicked(child):
	option_selected = true
	for opt in options.get_children():
		opt.set_tick_visible(false)
	
	child.set_tick_visible(true)


func _on_button_pressed() -> void:
	UiSound.play_sound_click()
	if option_selected:
		option_selected = false 
		load_question()
