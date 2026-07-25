extends Node2D

func _on_staff_room_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/staff_room.tscn")

func _on_mini_hall_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.door_dir = gRooms.DoorDir.TOP
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/hall.tscn")

func _on_mini_hall_entry_2_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.door_dir = gRooms.DoorDir.RIGHT
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/hall.tscn")

func _on_class_room_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/class_room.tscn")

func _on_go_home_body_entered(body: Node2D) -> void:
	if gRooms.story_state == gRooms.StoryState.GO_HOME:
		if body is Player:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Environment/Next_Day_image.tscn")

func _ready() -> void:
	match gRooms.out_pos:
		gRooms.OutPos.START:
			$Player.global_position = $Markers/Start.position
		gRooms.OutPos.STAFF:
			$Player.global_position = $Markers/StaffRoom.position
		gRooms.OutPos.HALL_TOP:
			$Player.global_position = $Markers/HallTop.position
		gRooms.OutPos.HALL_RIGHT:
			$Player.global_position = $Markers/HallRight.position
		gRooms.OutPos.CLASS:
			$Player.global_position = $Markers/Class.position
	if gRooms.story_state == gRooms.StoryState.INIT:
			$Player.start_timer_to_death(30)
			call_deferred("do_starting_stuff")
	elif gRooms.story_state == gRooms.StoryState.GO_HOME:
		$Player.start_timer_to_death(20)
		call_deferred("do_gohome_stuff")
	elif gRooms.story_state == gRooms.StoryState.NEXT_DAY:
			call_deferred("do_next_day_stuff")


const starting_text :Array[String] = [
	"I need to go to my class-room, I will be late!\nPress space to continue",
	"I need to find the class-room fast!",
	"The class-room is in the bottom right part of our school"
]

func do_starting_stuff():
	$Player.playerSay(starting_text)
	gRooms.story_state = gRooms.StoryState.FIND_CLASS

const go_home_etxt :Array[String] = [
	"WHAT WAS that exam...!",
	"Ugh.. I feel dizzy",
	"I should go home fast now..."
]

func do_gohome_stuff():
	$Player.playerSay(go_home_etxt)

const next_day_text :Array[String] = [
	"I wonder how I did in the exam...",
]

func do_next_day_stuff():
	$Player.playerSay(next_day_text)
