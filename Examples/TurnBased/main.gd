extends Node

enum turn {PLAYER, NPC, ENEMY}
var turn_current
var turn_label
var turn_counter

var player_label

var player
var npc
var enemy

var player_current
var ani

var speed = 10

func _ready():
	ani = get_node("CanvasLayer/AnimationPlayer")
	turn_label = get_node("CanvasLayer/Show Turn/Turn Text")
	player_label = get_node("CanvasLayer/Current Player")
	player = get_node("Player")
	npc = get_node("NPC")
	enemy = get_node("Enemy");
	
	player_current = player
	turn_current = turn.PLAYER;
	turn_counter = 1;
	
	#debug
	player_label.set_text("Current Player: " + player_current.get_name())
	restartRoundUI()
	
	set_process_input(true)
	set_process(true)

func _process(delta):
	handleMove(Input)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		nextTurn()

func nextTurn():
	if turn_current == turn.PLAYER:
		turn_current = turn.NPC
		player_current = npc
	elif turn_current == turn.NPC:
		turn_current = turn.ENEMY
		player_current = enemy
	elif turn_current == turn.ENEMY:
		turn_current = turn.PLAYER
		player_current = player
		turn_counter += 1
		restartRoundUI()
	
	#debug
	player_label.set_text("Current Player: " + player_current.get_name())
	

func handleMove(event):
	if event.is_action_pressed("ui_up"):
		player_current.set_pos(Vector2(player_current.get_pos().x, player_current.get_pos().y - speed))
	if event.is_action_pressed("ui_left"):
		player_current.set_pos(Vector2(player_current.get_pos().x - speed, player_current.get_pos().y))
	if event.is_action_pressed("ui_right"):
		player_current.set_pos(Vector2(player_current.get_pos().x + speed, player_current.get_pos().y))
	if event.is_action_pressed("ui_down"):
		player_current.set_pos(Vector2(player_current.get_pos().x, player_current.get_pos().y + speed))

func restartRoundUI():
	turn_label.set_text("Runde: " + String(turn_counter))
	ani.play("Start")

