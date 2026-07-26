extends Node2D

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	DialogueManager.stop_dialog()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/UI/MainMenu.tscn")
