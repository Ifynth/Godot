extends TileMap

onready var cursor = $Cursor
onready var background = $Background

#FIXME
export var fieldstart = Vector2(0,0)
export var fieldsizeX = 14
export var fieldsizeY = 7

func _ready():
	#FIXME
	cursor.size = cell_size.x
	cursor.fieldstart = fieldstart
	cursor.fieldsizeX = fieldsizeX
	cursor.fieldsizeY = fieldsizeY
	
	#FIXME
	background.size = cell_size.x
	background.position = fieldstart
	background.width = fieldsizeX
	background.height = fieldsizeY
	