extends KinematicBody2D

const GRAVITY = 10
const SPEED = 690
const JUMP_POWER = 500

var velocity = Vector2()

var grounded = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	velocity.y += GRAVITY
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0
	
	var motion = velocity * delta
	motion = move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		
		grounded = true
		
	else:
		grounded = false
	

func _input(event):
	if event.is_action_pressed("ui_up"):
		jump()

func jump():
	velocity.y = -JUMP_POWER
