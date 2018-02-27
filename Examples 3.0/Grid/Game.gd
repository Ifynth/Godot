extends Node

func _ready():
	$CameraMoving.connect("pressed", self, "onButtonSwitch", ["res://CameraMoving/Map.tscn"])
	$MovingCharakter.connect("pressed", self, "onButtonSwitch", ["res://MovingCharakter/Main.tscn"])

func onButtonSwitch(path):
	get_tree().change_scene(path)