extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.out_pos = gRooms.OutPos.STAFF
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")
