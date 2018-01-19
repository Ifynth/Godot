extends Control

var open
var cursor
var cursor_std_pos
var points
var points_index = 0
var label_distance = 50

func _ready():
	open = false
	cursor = get_node("Menu Cursor")
	cursor_std_pos = cursor.get_pos()
	points = get_node("Labels").get_children()
	set_process_input(true)

func _input(event):
	if open and event.is_action_released("ui_accept"):
		hide()
		open = false
		reset()
	elif !open and event.is_action_released("ui_accept"):
		show()
		open = true
	
	if open:
		if event.is_action_pressed("ui_up"):
			if points_index > 0:
				points_index -= 1
			else:
				points_index = points.size() - 1
			cursor.set_pos(Vector2(cursor.get_pos().x, cursor_std_pos.y + points_index * label_distance))
		elif event.is_action_pressed("ui_down"):
			if points_index < points.size() - 1:
				points_index += 1
			else:
				points_index = 0
			cursor.set_pos(Vector2(cursor.get_pos().x, cursor_std_pos.y + points_index * label_distance))

func reset():
	# TODO not neccessary if it is only there if it spawns
	cursor.set_pos(cursor_std_pos)
	points_index = 0