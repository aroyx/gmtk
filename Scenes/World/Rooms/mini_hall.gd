extends Node2D

func _ready() -> void:
	match gRooms.door_dir:
		gRooms.DoorDir.TOP:
			$Player.global_position = $Markers/OutSideTop.position
		gRooms.DoorDir.RIGHT:
			$Player.global_position = $Markers/OutSideRight.position
		gRooms.DoorDir.BOTTOM:
			$Player.global_position = $Markers/Hall.position

func _on_out_side_top_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.out_pos = gRooms.OutPos.MINI_TOP
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")

func _on_out_side_right_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.out_pos = gRooms.OutPos.MINI_RIGHT
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")

func _on_hall_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.door_dir = gRooms.DoorDir.TOP
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/hall.tscn")
