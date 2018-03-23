extends Node

#TODO start Animation, left hit right
# left -> attacker (Charakter.attacker)
# right -> defender (Charakter.defender)

func _ready():
	$"UI/Test Buttons/Test".connect("button_down", self, "onButtonTestPressed")
	$"UI/Test Buttons/Left Attack".connect("button_down", self, "simulateAttack", [Charakter.attacker, Charakter.defender, $UI/Defender])
	$"UI/Test Buttons/Right Attack".connect("button_down", self, "simulateAttack", [Charakter.defender, Charakter.attacker, $UI/Attacker])
	

func simulateAttack(attacker, defender, ui):
	# TODO (signal?)
	# HACK how to know which UI to use
	ui.takeDamage(defender.takeDamage(attacker.ATK))

func onButtonTestPressed():
	#print("Test")
	print("Fighting Chars: ")
	print("  Attacker: ", Charakter.attacker.get_name())
	setUI(Charakter.attacker, $UI/Attacker)
	print("  Defender: ", Charakter.defender.get_name())
	setUI(Charakter.defender, $UI/Defender)

func setUI(charakter, ui):
	print("Setting up UI for: ", charakter.get_name())
	# load Healthbar
	ui.createHealthbar(charakter.LP)