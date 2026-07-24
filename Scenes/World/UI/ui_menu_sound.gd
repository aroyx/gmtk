extends Node

var click_sounds: Array[AudioStream] = []

var sfx_player: AudioStreamPlayer

func _ready() -> void:
	sfx_player = AudioStreamPlayer.new()
	
	add_child(sfx_player)
	
	for i in range(1, 7):
		var path = "res://assets/audio/ui/menu_click_" + str(i) + ".wav"
		
		if ResourceLoader.exists(path):
			var stream = load(path) as AudioStream
			click_sounds.append(stream)
		else:
			print("The audio path doesn't exist! Path: " + path)

func play_sound_click():
	sfx_player.stream = click_sounds.pick_random()
	sfx_player.play()
