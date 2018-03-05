extends TileMap

export(int) var move = 2

func _ready():
	$"CanvasLayer/Place Field".connect("button_down", self, "drawField", [move])
	$"CanvasLayer/Remove Field".connect("button_down", $Fields, "removeField")
	$Fields.connect("delete_field", $Cursor, "deleteField")
	$Cursor.connect("moved", self, "updatePosition")

func drawField(step):
	$Fields.drawField(world_to_map($Cursor.position), step)

func updatePosition():
	if $Fields.draw_field:
		$Cursor.ex_field = $Fields.fields