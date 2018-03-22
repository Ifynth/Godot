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
	
	# HACK set the chars that have to fight
	attacker = charaktere[0]
	defender = charaktere[1]
