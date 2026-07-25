extends Node

enum DoorDir {NONE, TOP, BOTTOM, LEFT, RIGHT}
enum OutPos {START, STAFF, MINI_TOP, MINI_RIGHT, HALL, CLASS}

var door_dir = DoorDir.NONE
var out_pos = OutPos.START

enum StoryState {INIT, FIND_CLASS, SIT_TEST, TEST_END, GO_HOME, NEXT_DAY, HIDE_MARKSHEET}

var story_state = StoryState.INIT
