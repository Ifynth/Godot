extends Node

var charaktere = []

var attacker
var defender

func _ready():
	
	var dir = Directory.new()
	var path = "res://Components/Charaktere/"
	
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			charaktere.append(load(path+file_name).instance())
			file_name = dir.get_next()
	else:
		print("Couldn't open Directory! Path: ", path)
	
	# TODO ~ testing ~ (Remove if finished)
	setRandomFighter()

func setRandomFighter():
	"""
	# TODO could cause heavy loading
	# maybe better to save it into a array and pop them out
	attacker = getRandomChar()
	defender = getRandomChar()
	while attacker == defender:
		defender = getRandomChar()
	"""
	attacker = charaktere[0]
	defender = charaktere[1]

func getRandomChar():
	return charaktere[randi() % charaktere.size() - 1]
