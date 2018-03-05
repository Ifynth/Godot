extends TileMap

export(int) var move = 2

func _ready():
	$"CanvasLayer/Place Field".connect("button_down", self, "drawField", [move])
	$"CanvasLayer/Remove Field".connect("button_down", $Background, "removeField")
	$Cursor.connect("moved", self, "updatePosition")

func drawField(step):
	$Background.drawField(world_to_map($Cursor.position), step)

func updatePosition():
	print("Cursor Moved")