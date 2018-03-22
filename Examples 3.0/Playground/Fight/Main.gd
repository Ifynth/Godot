extends Node

#TODO start Animation, left hit right
# left -> attacker (Charakter.attacker)
# right -> defender (Charakter.defender)

func _ready():
	$"UI/Test Buttons/Test".connect("button_down", self, "onButtonTestPressed")
	

func onButtonTestPressed():
	print("Test")
	print("Fighting Chars: ")
	print("  Attacker: ", Charakter.attacker.get_name())
	print("  Defender: ", Charakter.defender.get_name())

