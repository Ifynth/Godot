extends Node

export(Vector2) var default_startpos = Vector2(0,0)
export(int) var move = 2

func _ready():
	$"CanvasLayer/Place Field".connect("button_down", $Background, "drawField", [default_startpos, move])
	$"CanvasLayer/Remove Field".connect("button_down", $Background, "removeField")