extends TileMap

export(int) var move = 2

func _ready():
	$"CanvasLayer/Place Field".connect("button_down", self, "onButttonDrawField")
	$"CanvasLayer/Remove Field".connect("button_down", self, "onButtonRemoveField")
	$Fields.connect("delete_field", $Cursor, "deleteField")
	$Cursor.connect("moved", self, "updatePosition")

func _input(event):
	#testing
	if event.is_action_pressed("ui_accept"):
		onButtonRemoveField()
		onButttonDrawField()

func onButttonDrawField():
	$Fields.drawField(world_to_map($Cursor.position), move)
	$Arrow.createArrow($Cursor.position, move)

func onButtonRemoveField():
	$Fields.removeField()
	$Arrow.delArrow()

func updatePosition():
	if $Fields.draw_field:
		$Cursor.ex_field = $Fields.fields
		
		#give Arrow his new body
		$Arrow.addBody($Cursor.position)