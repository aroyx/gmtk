extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	gRooms.story_state = gRooms.StoryState.NEXT_DAY

func _on_timer_timeout() -> void:
	gRooms.out_pos = gRooms.OutPos.CLASS
	DialogueManager.stop_dialog()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")
