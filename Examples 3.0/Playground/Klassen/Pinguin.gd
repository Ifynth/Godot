extends Node
#extends "res://Klassen/Animal.gd"

var name_
var rasse = "Penguin"

func _init(name):
	self.name_ = name
	
func shoutout():
	print("My name is: " + name_ + " and I am a " + rasse)