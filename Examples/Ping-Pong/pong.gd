extends Node2D

# Member variables
var screen_size
var pad_size
var direction = Vector2(1.0,0.0)

# Constant for pad speed (in pixels/second)
const INITIAL_BALL_SPEED = 80
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 150

# Label für Score
var score_node
var left_score
var right_score

var left_node
var right_node

var strg_view

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()
	score_node = get_node("Score")
	left_node = get_node("left")
	right_node = get_node("right")
	strg_view = true
	
	# schaut zurzeit wegen dem Seperator nicht gut aus
	score_node.hide()
	
	# Set Positioning von Nodes
	score_node.set_pos(Vector2(screen_size.x * 0.5 - score_node.get_size().x * 0.5, 40))
	get_node("Left_Score").set_pos(Vector2(screen_size.x * 0.25, 60))
	get_node("Right_Score").set_pos(Vector2(screen_size.x * 0.75, 60))
	left_node.set_pos(Vector2(screen_size.x *0.1 - left_node.get_texture().get_size().x * 0.5, screen_size.y *0.5))
	right_node.set_pos(Vector2(screen_size.x *0.9 + right_node.get_texture().get_size().x * 0.5, screen_size.y *0.5))
	get_node("ball").set_pos(screen_size * 0.5)
	
	left_score = 0
	right_score = 0
	set_process(true)

func _process(delta):
	var ball_pos = get_node("ball").get_pos()
	var left_rect = Rect2(get_node("left").get_pos() - pad_size*0.5, pad_size)
	var right_rect = Rect2(get_node("right").get_pos() - pad_size*0.5, pad_size)
	
	# Integrate new ball position
	ball_pos += direction * ball_speed * delta
	
	# Flip when touching roof or floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
	
	# Flip, change direction and increase speed when touching pads
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	
	# Check gameover
	if (ball_pos.x < 0 or ball_pos.x > screen_size.x):
		ball_pos = screen_size*0.5
		ball_speed = INITIAL_BALL_SPEED
		if direction.x > 0:
			direction = Vector2(1, 0)
			left_score += 1
		else:
			direction = Vector2(-1, 0)
			right_score += 1
	
	get_node("ball").set_pos(ball_pos)
	
	# Move left pad
	var left_pos = get_node("left").get_pos()
	
	if (left_pos.y > 0 and Input.is_action_pressed("left_move_up")):
		left_pos.y += -PAD_SPEED * delta
		strg_view = false
	if (left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down")):
		left_pos.y += PAD_SPEED * delta
		strg_view = false
	
	get_node("left").set_pos(left_pos)
	
	# Move right pad
	var right_pos = get_node("right").get_pos()
	
	if (right_pos.y > 0 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -PAD_SPEED * delta
		strg_view = false
	if (right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down")):
		right_pos.y += PAD_SPEED * delta
		strg_view = false
	
	get_node("right").set_pos(right_pos)
	
	# Points Stats
	get_node("Left_Score").set_text(String(left_score))
	get_node("Right_Score").set_text(String(right_score))
	
	# Configuration View ausschalten nach bewegung der Pads
	if !strg_view and get_node("Control") != null:
		get_node("Control").hide()
		