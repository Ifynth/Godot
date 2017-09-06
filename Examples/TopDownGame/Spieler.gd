extends KinematicBody2D

export var PLAYER_SPEED = 200

var direction

func _ready():
	set_process(true)
	
	direction = Vector2()

func _process(delta):
	
	direction = Vector2()
	
	#Input
	
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1,0)
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0,-1)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1,0)
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0,1)
	
	move(direction.normalized()*PLAYER_SPEED*delta)