extends TileMap

export(int) var move = 2

func _ready():
	# TODO Ask: 
	# 	1. write a 1 Line Code in the connect function
	# 	2. params should be updated if pressed ...
	$"CanvasLayer/Place Field".connect("button_down", self, "drawField", [move])
	$"CanvasLayer/Remove Field".connect("button_down", $Background, "removeField")
	$Background.connect("delete_field", $Cursor, "deleteField")
	$Cursor.connect("moved", self, "updatePosition")

func drawField(step):
	$Background.drawField(world_to_map($Cursor.position), step)

func updatePosition():
	if $Background.draw_field:
		print("Cursor Moved, while it is marked with fields")
		$Cursor.ex_field = $Background.fields