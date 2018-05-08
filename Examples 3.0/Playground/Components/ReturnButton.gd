extends Button

func _ready():
	self.connect("button_down", self, "switchToMenu")

func switchToMenu():
	get_tree().change_scene("res://Game.tscn")