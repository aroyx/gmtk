extends Node2D

func _on_staff_room_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/staff_room.tscn")

func _on_mini_hall_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.door_dir = gRooms.DoorDir.TOP
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/mini_hall.tscn")

func _on_mini_hall_entry_2_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.door_dir = gRooms.DoorDir.RIGHT
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/mini_hall.tscn")

func _on_hall_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.door_dir = gRooms.DoorDir.RIGHT
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/hall.tscn")

func _on_class_room_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/class_room.tscn")

func _ready() -> void:
	match gRooms.out_pos:
		gRooms.OutPos.START:
			$Player.global_position = $Markers/Start.position
		gRooms.OutPos.STAFF:
			$Player.global_position = $Markers/StaffRoom.position
		gRooms.OutPos.MINI_TOP:
			$Player.global_position = $Markers/MiniTop.position
		gRooms.OutPos.MINI_RIGHT:
			$Player.global_position = $Markers/MiniRight.position
		gRooms.OutPos.HALL:
			$Player.global_position = $Markers/Hall.position
		gRooms.OutPos.CLASS:
			$Player.global_position = $Markers/Class.position
