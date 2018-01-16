extends Control

var open

func _ready():
	open = false
	set_process_input(true)

func _input(event):
	if open and event.is_action_released("ui_accept"):
		hide()
		open = false
	elif !open and event.is_action_released("ui_accept"):
		show()
		open = true
