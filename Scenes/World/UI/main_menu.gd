extends Node2D

func _on_button_pressed() -> void:
	UiSound.play_sound_click()
	get_tree().change_scene_to_file("res://Scenes/World/StartingTest/StartingTest.tscn")
