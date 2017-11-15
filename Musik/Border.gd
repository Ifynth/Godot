extends Node2D

var border
var timer
var label_great
var label_normal
var label_bad

var bps = 2
var count_great = 0
var count_normal = 0
var count_bad = 0

func _ready():
	border = get_node("BorderTop")
	timer = get_node("Timer")
	label_great = get_node("Control/Great")
	label_normal = get_node("Control/Normal")
	label_bad = get_node("Control/Bad")
	
	timer.set_wait_time(timer.get_wait_time() / bps)
	
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	border.set_opacity(timer.get_time_left() * bps)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if timer.get_time_left() < timer.get_wait_time() * 0.2 or timer.get_time_left() > timer.get_wait_time() * 0.8:
			count_great += 1
			label_great.set_text("Great Count : " + String(count_great))
		elif timer.get_time_left() < timer.get_wait_time() * 0.35 or timer.get_time_left() > timer.get_wait_time() * 0.65:
			count_normal += 1
			label_normal.set_text("Normal Count : " + String(count_normal))
		else:
			count_bad += 1
			label_bad.set_text("Bad Count : " + String(count_bad))
	