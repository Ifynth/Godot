extends Node

func _ready():
	#$CameraMoving.connect("pressed", self, "onButtonSwitch", ["res://CameraMoving/Map.tscn"])
	#$MovingCharakter.connect("pressed", self, "onButtonSwitch", ["res://MovingCharakter/Main.tscn"])
	#$AfterDrawing.connect("pressed", self, "onButtonSwitch", ["res://AfterDrawing/Main.tscn"])
	
	for child in get_children():
		child.connect("pressed", self, "onButtonSwitch", ["res://"+child.get_name()+"/Main.tscn"])

func onButtonSwitch(path):
	get_tree().change_scene(path)