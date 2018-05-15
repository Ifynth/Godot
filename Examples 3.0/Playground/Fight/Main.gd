extends Node

var attacker
var defender

func _ready():
	"""
	# could cause heavy loading
	# maybe better to save it into a array and pop them out
	attacker = Charakter.getRandomChar()
	defender = Charakter.getRandomChar()
	while attacker == defender:
		defender = Charakter.getRandomChar()
	"""
	attacker = Charakter.charaktere[0]
	defender = Charakter.charaktere[1]
	
	# Set Button Function
	$"UI/Test Buttons/Test".connect("button_down", self, "onButtonTestPressed")
	$"UI/Test Buttons/Left Attack".connect("button_down", self, "simulateAttack", [attacker, defender, $UI/Defender])
	$"UI/Test Buttons/Right Attack".connect("button_down", self, "simulateAttack", [defender, attacker, $UI/Attacker])
	$"UI/Test Buttons/End Fight".connect("button_down", self, "endFight")
	
	# Print Additional Info and Setting UI
	print("Fighting Chars: ")
	print("  Attacker: ", attacker.get_name())
	setUI(attacker, $UI/Attacker)
	print("  Defender: ", defender.get_name())
	setUI(defender, $UI/Defender)
	

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
