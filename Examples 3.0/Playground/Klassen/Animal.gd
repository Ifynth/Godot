extends Node

const Tiger = preload("res://Klassen/Tiger.gd")
const Pinguin = preload("res://Klassen/Pinguin.gd")

var name_

func _init(name):
	name_ = name

func getTiger():
	return Tiger.new(name_)

func getPinguin():
	return Pinguin.new(name_)

func shoutout():
	print("My name is: " + name_)