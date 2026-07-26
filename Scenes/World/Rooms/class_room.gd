extends Node2D

const teacher_lines: Array[String] = [
	"You are late!",
	"go sit in your bench now!",
	"In this room no one else\nis giving the exam",
	"this is a special exam\ndesigned for you!"
]

const teacher_go_home_dialog: Array[String] = [
	"I hope, you gave a very good exam",
	">:)",
	"I hope you pass, good bye >:)",
	"travel safe >:)",
	"go home now!",
	"the same way you came here"
]

const teacher_nextday_dialog: Array[String] = [
	"Look who's back",
	"You want to know how much you got?\ncome here, see this!",
]

@onready var marker = $Teacher/TextBubbleMarker

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hide"):
		if in_chair:
			DialogueManager.stop_dialog()
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/StartingTest/StartingTest.tscn")


func _ready() -> void:
	$Teacher/AnimatedSprite2D.play()
	$TableChairs2/Label.hide()
	if gRooms.story_state == gRooms.StoryState.FIND_CLASS:
		call_deferred("trigger_teacher_findclass_dialogue")
		gRooms.story_state = gRooms.StoryState.SIT_TEST
	elif gRooms.story_state == gRooms.StoryState.TEST_END:
		call_deferred("trigger_teacher_gohome_dialogue")
		gRooms.story_state = gRooms.StoryState.GO_HOME
	elif gRooms.story_state == gRooms.StoryState.NEXT_DAY:
		call_deferred("trigger_teacher_nextday_dialogue")

func trigger_teacher_findclass_dialogue() -> void:
	DialogueManager.start_dialog(marker.global_position, teacher_lines, $Teacher)

func trigger_teacher_gohome_dialogue() -> void:
	DialogueManager.start_dialog(marker.global_position, teacher_go_home_dialog, $Teacher)

func trigger_teacher_nextday_dialogue() -> void:
	DialogueManager.start_dialog(marker.global_position, teacher_nextday_dialog, $Teacher)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		gRooms.out_pos = gRooms.OutPos.CLASS
		DialogueManager.stop_dialog()
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/World/Rooms/outside.tscn")

var in_chair = false

func _on_chair_body_entered(body: Node2D) -> void:
	in_chair = true
	if body is Player && gRooms.story_state == gRooms.StoryState.SIT_TEST:
		$TableChairs2/Label.show()

func _on_chair_body_exited(body: Node2D) -> void:
	in_chair = false
	if body is Player && gRooms.story_state == gRooms.StoryState.SIT_TEST:
		$TableChairs2/Label.hide()

const player_shocked_dialog : Array[String] = [
	"Woah!",
	"How did this happen!",
	"I used to be a topper!",
	"how did I got this less marks!",
	"0 to be specific",
	"how did I get so less marks, nooooo!! ;(",
	"I need to hide my marks from my bullies, I can't let them know about this",
	"they'll bully me",
	"I should go in the hall to see what ppl are doing there"
]

func _on_teacher_body_entered(body: Node2D) -> void:
	if gRooms.story_state == gRooms.StoryState.NEXT_DAY:
		if body is Player:
			body.playerSay(player_shocked_dialog)
			gRooms.story_state = gRooms.StoryState.HIDE_MARKSHEET
