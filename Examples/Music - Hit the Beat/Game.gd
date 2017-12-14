extends Node

enum QUESTION {WAIT, TOP, LEFT, RIGHT, BOTTOM}
var inquiry

export var bps = 1
var border
var beat_timer
var start_timer
var open_answer
var counter = 3

var score = 0

func _ready():
	
	start_timer = get_node("StartTimer")
	beat_timer = get_node("BeatTimer")
	border = get_node("Border").get_children()
	
	start_timer.connect("timeout", self, "game_starts")
	beat_timer.set_wait_time(beat_timer.get_wait_time() / bps)
	beat_timer.connect("timeout", self, "next_inquiry")
	
	# if beat_timer Autostart isn't enabled
	# beat_timer.start() 
	
	set_process(true)
	set_process_input(true)

func _process(delta):
	for side in border:
		# if for sinus form
		if beat_timer.get_time_left() * bps < 0.5:
			side.set_opacity(beat_timer.get_time_left() * bps * 2)
		else:
			side.set_opacity(2.0 - beat_timer.get_time_left() * bps * 2)
	
	# update Score
	get_node("Score/Score Counter").set_text(String(score))

func _input(event):
	if open_answer:
		if event.is_action_pressed("ui_up"):
			check_correct(QUESTION.TOP)
		if event.is_action_pressed("ui_left"):
			check_correct(QUESTION.LEFT)
		if event.is_action_pressed("ui_right"):
			check_correct(QUESTION.RIGHT)
		if event.is_action_pressed("ui_down"):
			check_correct(QUESTION.BOTTOM)
	

func game_starts():
	if counter == 3:
		print_message("Ready")
		print_start("Ready")
	elif counter == 2:
		print_message("Set")
		print_start("Set")
	elif counter == 1:
		print_message("Go")
		print_start("GO!")

func next_inquiry():
	if counter == 0:
		if open_answer and inquiry != QUESTION.WAIT:
			print_message("Missed")
			print("Missed!")
		randomize()
		inquiry = randi() % 5
		if inquiry == QUESTION.WAIT:
			print_message("Wait", true)
		elif inquiry == QUESTION.TOP:
			print_message("Top", true)
		elif inquiry == QUESTION.LEFT:
			print_message("Left", true)
		elif inquiry == QUESTION.RIGHT:
			print_message("Right", true)
		elif inquiry == QUESTION.BOTTOM:
			print_message("Bottom", true)
		open_answer = true
		# print inquiry

func print_start(text):
	print(text)
	counter -= 1
	start_timer.start()

func print_message(name, random = false):
	var file = load("res://Message/Message.tscn")
	var node = file.instance()
	var x = 512
	var y = 300
	if random:
		randomize()
		x = randi() % 724 + 150
		randomize()
		y = randi() % 460 + 70
	node.set_pos(Vector2(x, y))
	node.changeSprite(name)
	add_child(node)

func check_correct(answer):
	if inquiry == answer:
		score_points()
	open_answer = false

func score_points():
	# score points
	var multi = 1000
	var points = 0
	if beat_timer.get_time_left() * bps < 0.5:
		points = beat_timer.get_time_left() * bps * 2
	else:
		points = 2.0 - beat_timer.get_time_left() * bps * 2
	
	if beat_timer.get_time_left() * bps > 0.35 and beat_timer.get_time_left() * bps < 0.65:
		multi *= 1.5
		print_message("Great")
		print("Great!")
	else:
		print_message("Good")
		print("Good")
	score += int(points * multi)
	print("Score Points")
	
