extends TileMap

# States:
# 	Default -> Moving
# 	Picked_up -> a Charakter is Binded on the Cursor
enum states {DEFAULT, PICKED_UP}
var state
var picked_up

var FIELD = []

var width = 16
var height = 9
var size = 64

func _ready():
	# unnötig (um perfekte größe zu erschaffen)
	OS.window_size.y = 576
	
	state = DEFAULT
	
	for x in range(width):
		FIELD.append([])
		for y in range(height):
			FIELD[x].append(null)
			for child in $Good.get_children():
				if child.position.x == x * size and child.position.y == y * size:
					FIELD[x][y] = child
			for child in $Evil.get_children():
				if child.position.x == x * size and child.position.y == y * size:
					FIELD[x][y] = child
	

func _input(event):
	
	match(state):
		DEFAULT:
			handleDefaultInput(event)
		PICKED_UP:
			handlePickedUpInput(event)
	

func handleDefaultInput(event):
	if event.is_action_pressed("ui_accept") && getFieldOnCursor() && getFieldOnCursor().get_parent().is_in_group("good"):
		print("Pick up: ", getFieldOnCursor().get_name())
		picked_up = getFieldOnCursor()
		$Background.emit_signal("draw")
		state = PICKED_UP
	

func handlePickedUpInput(event):
	if event.is_action_pressed("ui_accept") && !FIELD[world_to_map($Cursor.position).x][world_to_map($Cursor.position).y]:
		print("Drop ", picked_up.get_name())
		# Wenn es Frei ist 
		# Setze den Char auf das Feld (FIELD & Visuell)
		setFieldOnCursor(picked_up)
		picked_up.position = $Cursor.position
		picked_up = null
		state = DEFAULT

# no use anymore
func set_Charakter_position_in_field(parent, x, y):
	for child in parent.get_children():
		if child.position.x == x * size and child.position.y == y * size:
			FIELD[x][y] = child

func getFieldOnCursor():
	return FIELD[world_to_map($Cursor.position).x][world_to_map($Cursor.position).y]

func setFieldOnCursor(child):
	FIELD[world_to_map(child.position).x][world_to_map(child.position).y] = null
	FIELD[world_to_map($Cursor.position).x][world_to_map($Cursor.position).y] = child
