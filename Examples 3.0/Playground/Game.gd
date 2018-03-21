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
	
	if dir.open(path) == OK:
		dir.list_dir_begin(true, !hidden)
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir() and ignore.find(file_name) == -1 and checkMainScene(path + file_name):
				var button = Button.new()
				button.set_name(file_name)
				button.set_text(file_name)
				button.rect_position = button_pos
				add_child(button)
				button_pos.y += 20
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func checkMainScene(path):
	# Check if Folder have a Main Scene
	var dir = Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name == "Main.tscn":
				dir.list_dir_end()
				return true
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return false

