extends TileMap

export(int) var move = 2

# TODO Ask: 
# 	1. write a 1 Line Code in the connect function
# 	2. params should be updated if pressed ...

func _ready():
	$"CanvasLayer/Place Field".connect("button_down", self, "drawField", [move])
	$"CanvasLayer/Remove Field".connect("button_down", $Fields, "removeField")
	$Fields.connect("delete_field", $Cursor, "deleteField")
	$Cursor.connect("moved", self, "updatePosition")

func drawField(step):
	$Fields.drawField(world_to_map($Cursor.position), step)

func updatePosition():
	if $Fields.draw_field:
		print("Cursor Moved, while it is marked with fields")
		$Cursor.ex_field = $Fields.fields