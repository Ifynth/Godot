extends KinematicBody2D

"""
# docu #1
func _physics_process(delta):
	move_and_collide(Vector2(0, 1)) # Move down 1 pixel per physics frame
	
"""

"""
# docu #2 (why 2x delta)
const GRAVITY = 200.0
var velocity = Vector2()

func _physics_process(delta):
    velocity.y += delta * GRAVITY

    var motion = velocity * delta
    move_and_collide(motion)
"""

const GRAVITY = 890.0
const WALK_SPEED = 200
const JUMP_POWER = 400

var velocity = Vector2()

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up"):
		print (velocity)
		velocity.y = -JUMP_POWER
	
	# We don't need to multiply velocity by delta because MoveAndSlide already takes delta time into account.
	
	# The second parameter of move_and_slide is the normal pointing up.
	# In the case of a 2d platformer, in Godot upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))
