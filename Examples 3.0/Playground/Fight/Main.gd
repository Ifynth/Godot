extends Node

#TODO start Animation, left hit right

func _ready():
	$"UI/Test Buttons/Test".connect("button_down", self, "onButtonTestPressed")

func onButtonTestPressed():
	print("Test")
	print("Fighting Chars: ")
	print(Charakter.getFightChars())

