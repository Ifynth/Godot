extends Node

func _ready():
	createButtonFolder(["Ressourcen"])
	
	for child in get_children():
		child.connect("pressed", self, "onButtonSwitch", ["res://"+child.get_name()+"/Main.tscn"])

func onButtonSwitch(path):
	get_tree().change_scene(path)

func createButtonFolder(ignore = [], hidden = false):
	var button_pos = Vector2(0,0)
	var path = "res://"
	var dir = Directory.new()
	ignore.append(".")
	ignore.append("..")
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir() and ignore.find(file_name) == -1 and checkMainScene(path + file_name):
				if hidden:
					addButton(file_name, button_pos)
					button_pos.y += 20
				else:
					if file_name[0] != ".":
						addButton(file_name, button_pos)
						button_pos.y += 20
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func addButton(name, pos):
	var button = Button.new()
	button.set_name(name)
	button.set_text(name)
	button.rect_position = pos
	add_child(button)
	

func checkMainScene(path):
	# Check if Folder have a Main Scene
	var dir = Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name == "Main.tscn":
				return true
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return false

