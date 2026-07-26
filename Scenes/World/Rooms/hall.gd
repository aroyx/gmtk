extends Node2D

func _ready() -> void:
	match gRooms.door_dir:
		gRooms.DoorDir.TOP:
			$Player.global_position = $Markers/Top.position
		gRooms.DoorDir.RIGHT:
			$Player.global_position = $Markers/Right.position

func _on_mini_hall_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.out_pos = gRooms.OutPos.HALL_TOP
		DialogueManager.stop_dialog()
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")

func _on_out_side_right_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.out_pos = gRooms.OutPos.HALL_RIGHT
		DialogueManager.stop_dialog()
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")
