extends Sprite

var grid
var menu

var menu_open
var menu_close
var menu_move
var menu_attack

var modus_move
var modus_attack

var green_scene
var red_scene
var movement_Node
var attack_Node

var greenfields = []
var redfields = []

var width = 12
var height = 10

var fieldSize

func _ready():
	grid = get_parent().get_node("TileMap")
	menu = get_parent().get_node("Menu/menuList")
	get_parent().get_node("TileMap/ShowGritField").update()
	
	randomize()
	var x = randi() % (width - 1)
	var y = randi() % (height - 1)
	
	get_parent().get_node("GoodFig/Schwert").set_pos(grid.map_to_world(Vector2(x,y)))
	
	var x1 = randi() % (width - 1)
	var y1 = randi() % (height - 1)
	
	while x == x1 and y == y1:
		x1 = randi() % (width - 1)
		y1 = randi() % (height - 1)
	
	get_parent().get_node("EvilFig/Schwert").set_pos(grid.map_to_world(Vector2(x1,y1)))
	
	fieldSize = Vector2(60,60)
	
	menu_open = false
	menu_close = false
	menu_move = false
	menu_attack = false
	
	modus_move = false
	modus_attack = false
	
	set_process_input(true)

func _input(event):
	
	# Keyboard on the Field
	if event.is_action_pressed("ui_up") and get_pos().y > 64 and not menu_open:
		set_pos(Vector2(get_pos().x, get_pos().y-64))
	if event.is_action_pressed("ui_down") and get_pos().y < height*64-64*2 and not menu_open:
		set_pos(Vector2(get_pos().x, get_pos().y+64))
	if event.is_action_pressed("ui_left") and get_pos().x > 64 and not menu_open:
		set_pos(Vector2(get_pos().x-64, get_pos().y))
	if event.is_action_pressed("ui_right") and get_pos().x < width*64-64*2 and not menu_open:
		set_pos(Vector2(get_pos().x+64, get_pos().y))
	
	# Move the Figure
	if modus_move and ((event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept")):
		if greenfields.find(Vector2(get_pos().x-32, get_pos().y-32)) != -1:
			get_parent().get_node("GoodFig/Schwert").set_pos(get_pos() - Vector2(32, 32))
		grid.remove_child(movement_Node)
		grid.remove_child(attack_Node)
		greenfields = []
		redfields = []
		modus_move = false
		menu_close = true
	
	if modus_attack and ((event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept")):
		if get_pos() == get_parent().get_node("EvilFig/Schwert").get_pos() + Vector2(32, 32) and redfields.find(Vector2(get_pos().x-32, get_pos().y-32)) != -1:
			print("ATTACK!!!")
			get_tree().change_scene("res://Fight.tscn")
		grid.remove_child(attack_Node)
		redfields = []
		modus_attack = false
		menu_close = true
	
	if menu_open:
		if event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_WHEEL_UP:
			menu.select(0)
		elif event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_WHEEL_DOWN:
			menu.select(1)
	
	# if a element is selected from menue then 
	if ((event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept")) and menu_open and menu.is_selected(0):
		menu.clear()
		menu_open = false
		menu_close = true
		menu_move = true
	elif ((event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept")) and menu_open and menu.is_selected(1):
		menu.clear()
		menu_open = false
		menu_close = true
		menu_attack = true
	
	if menu_move:
		
		var step = 3
		var aktpos = grid.world_to_map(get_pos())
		
		get_fields(aktpos, step+1, redfields)
		
		red_scene = load("res://MoveField.tscn")
		attack_Node = red_scene.instance()
		attack_Node.get_child(0).set_fields(redfields, fieldSize)
		attack_Node.get_child(0).set_color("#DD0000")
		grid.add_child(attack_Node)
		
		
		get_fields(aktpos, step, greenfields)
		
		green_scene = load("res://MoveField.tscn")
		movement_Node = green_scene.instance()
		movement_Node.get_child(0).set_fields(greenfields, fieldSize)
		movement_Node.get_child(0).set_color("#00DD00")
		grid.add_child(movement_Node)
		
		
		modus_move = true
		menu_move = false
	
	if menu_attack:
		
		var step = 1
		var aktpos = grid.world_to_map(get_pos())
		
		get_fields(aktpos, step, redfields)
		
		red_scene = load("res://MoveField.tscn")
		attack_Node = red_scene.instance()
		attack_Node.get_child(0).set_fields(redfields, fieldSize)
		attack_Node.get_child(0).set_color("#DD0000")
		grid.add_child(attack_Node)
		
		modus_attack = true
		menu_attack = false
	
	# Accept Keyboard + Mouse
	if ((event.type==InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept")) and menu.get_item_count() == 0 and not menu_open and not menu_close:
		if grid.world_to_map(get_pos()) == grid.world_to_map(get_parent().get_node("GoodFig/Schwert").get_pos()):
			menu_open = true
			menu.clear()
			menu.add_item("Bewegen")
			menu.add_item("Angreifen")
			menu.select(0)
			menu.grab_focus()
		else:
			menu.clear()
	
	menu_close = false
	
	# Mouse on the Field
	if (event.type==InputEvent.MOUSE_MOTION) and (grid.world_to_map(event.pos) != grid.world_to_map(get_pos())) and event.y > 0 and event.y < height*64 - 64 and event.x > 0 and event.x < width*64-64 and menu.get_item_count() == 0 and not menu_open:
		set_pos(grid.map_to_world(grid.world_to_map(event.pos)) + grid.get_cell_size()/2)


func get_fields(pos, step, finarr):
	if finarr.find(grid.map_to_world(pos)) == -1:
		finarr.append(grid.map_to_world(pos))
	
	
	# 1 für z.B gras
	# if FIELD[x][y+1] == "1"
	
	#top
	if step > 0:
		get_fields(Vector2(pos.x, pos.y-1), step-1, finarr)
	
	#left
	if step > 0:
		get_fields(Vector2(pos.x-1, pos.y), step-1, finarr)
	
	#right
	if step > 0:
		get_fields(Vector2(pos.x+1, pos.y), step-1, finarr)
	
	#bottom
	if step > 0:
		get_fields(Vector2(pos.x, pos.y+1), step-1, finarr)
