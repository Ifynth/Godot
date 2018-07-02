extends "res://Klassen/Animal.gd"

var rasse = "Tiger"

func _init(name):
	print("call Tiger init")
	self.name_ = name

func shoutout():
	print("My name is: " + name_ + " and I am a " + rasse)