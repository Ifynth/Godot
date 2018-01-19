extends KinematicBody2D

var direction = Vector2(0,0)
var menu_closed

func _ready():
	menu_closed = get_node("../CanvasLayer/Menu").is_hidden()
	set_fixed_process(true)

func _fixed_process(delta):
	direction = Vector2(0,0)
	
	if menu_closed:
		if Input.is_action_pressed("ui_up"):
			direction = Vector2(0,-1)
		elif Input.is_action_pressed("ui_down"):
			direction = Vector2(0,1)
		elif Input.is_action_pressed("ui_left"):
			direction = Vector2(-1,0)
		elif Input.is_action_pressed("ui_right"):
			direction = Vector2(1,0)
	
	move(direction)

func _on_Menu_visibility_changed():
	# FIX Wird beim ersten Aufruf doppelt ausgeführt ?!?
	menu_closed = get_node("../CanvasLayer/Menu").is_hidden()
