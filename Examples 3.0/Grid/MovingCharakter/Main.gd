extends TileMap

var FIELD = []

var width = 16
var height = 9
var size = 64

func _ready():
	# unnötig (um perfekte größe zu erschaffen
	OS.window_size.y = 576
	
	for x in range(width):
		FIELD.append([])
		for y in range(height):
			FIELD[x].append([])
			set_Charakter_position_in_field($Good, x, y)
			set_Charakter_position_in_field($Evil, x, y)
	print(FIELD)
	
	

func set_Charakter_position_in_field(parent, x, y):
	for child in parent.get_children():
		if child.position.x == x * size and child.position.y == y * size:
			FIELD[x][y] = child

