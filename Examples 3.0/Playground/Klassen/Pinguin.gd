extends "res://Klassen/Animal.gd"

var rasse = "Penguin"

func _init(name):
	print("call Pinguin init")
	self.name_ = name
	
func shoutout():
	print("My name is: " + name_ + " and I am a " + rasse)