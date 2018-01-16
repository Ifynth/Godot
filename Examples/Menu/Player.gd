extends KinematicBody2D

var direction = Vector2(0,0)

func _ready():
	set_process(true)

func _process(delta):
	direction = Vector2(0,0)
	
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(0,-1)
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(0,1)
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2(-1,0)
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(1,0)
	
	move(direction)