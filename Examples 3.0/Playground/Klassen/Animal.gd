extends Node

var name_

func _init(name):
	print("Call Animal init")
	name_ = name

func shoutout():
	print("My name is: " + name_)