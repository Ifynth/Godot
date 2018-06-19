extends Node2D

enum { DEFAULT, UP, LEFT, RIGHT, DOWN }

onready var akt_pos = $Points/Point1
onready var field = {
	$Points/Point1.name: { 
		UP: $Points/Point3,
		RIGHT: $Points/Point3,
		DOWN: $Points/Point2
	},
	$Points/Point2.name: { 
		UP: $Points/Point3,
	},
	$Points/Point3.name: { 
		LEFT: $Points/Point1,
	}
}

var path = null
var moving = false

func _ready():
	#testing
	print(checkDirectionAvailable(akt_pos, "up"))
	print(checkDirectionAvailable(akt_pos, "left"))
	print(checkDirectionAvailable(akt_pos, "right"))
	print(checkDirectionAvailable(akt_pos, "down"))

func _input(event):
	
	if !moving: 
		if event.is_action_pressed("ui_up"):
			print("up pressed")
			path = checkDirectionAvailable(akt_pos, "up")
			if path != null:
				path.start_tween()
				moving = true
		elif event.is_action_pressed("ui_left"):
			print("left pressed")
			path = checkDirectionAvailable(akt_pos, "left")
			if path != null:
				path.start_tween()
				moving = true
		elif event.is_action_pressed("ui_right"):
			print("right pressed")
			path = checkDirectionAvailable(akt_pos, "right")
			if path != null:
				path.start_tween()
				moving = true
		elif event.is_action_pressed("ui_down"):
			print("down pressed")
			path = checkDirectionAvailable(akt_pos, "down")
			if path != null:
				path.start_tween()
				moving = true
	 

func checkDirectionAvailable(point, direction):
	for path in point.get_children():
		# FIX ME HACK
		if path is Path2D:
			if ( path.direction == path.D.UP and direction == "up" ) || ( path.direction == path.D.LEFT and direction == "left" ) || ( path.direction == path.D.RIGHT and direction == "right" ) || ( path.direction == path.D.DOWN and direction == "down" ):
				return path
	return null

func _physics_process(delta):
	if moving: 
		$Charakter.position = path.get_follow_pos() + path.get_parent().position

func stop_move(object, key):
	print("stop moving")
	akt_pos = field[akt_pos.name][path.direction]
	print(akt_pos)
	path = null
	moving = false