extends Node

func _ready():
	for child in get_children():
		child.connect("pressed", self, "onButtonSwitch", ["res://"+child.get_name()+"/Main.tscn"])

func onButtonSwitch(path):
	get_tree().change_scene(path)