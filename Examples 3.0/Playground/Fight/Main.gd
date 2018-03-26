extends Node

"""
enum {LEFT, RIGHT}
var start = LEFT
"""

func _ready():
	$"UI/Test Buttons/Test".connect("button_down", self, "onButtonTestPressed")
	$"UI/Test Buttons/Left Attack".connect("button_down", self, "simulateAttack", [Charakter.attacker, Charakter.defender, $UI/Defender])
	$"UI/Test Buttons/Right Attack".connect("button_down", self, "simulateAttack", [Charakter.defender, Charakter.attacker, $UI/Attacker])
	$"UI/Test Buttons/End Fight".connect("button_down", self, "endFight")
	
	print("Fighting Chars: ")
	print("  Attacker: ", Charakter.attacker.get_name())
	setUI(Charakter.attacker, $UI/Attacker)
	print("  Defender: ", Charakter.defender.get_name())
	setUI(Charakter.defender, $UI/Defender)
	

func simulateAttack(attacker, defender, ui):
	ui.takeDamage(defender.takeDamage(attacker.ATK))

func onButtonTestPressed():
	print("Test")
	"""
	# OS.delay_msec(4000)
	# start Hitting
	if start == LEFT:
		simulateAttack(Charakter.attacker, Charakter.defender, $UI/Defender)
	else:
		simulateAttack(Charakter.defender, Charakter.attacker, $UI/Attacker)
	"""

func endFight():
	get_tree().change_scene("res://Game.tscn")

func setUI(charakter, ui):
	print("Setting up UI for: ", charakter.get_name())
	# load Healthbar
	ui.createHealthbar(charakter.LP)