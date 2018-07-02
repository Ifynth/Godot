extends Node

const Animal = preload("res://Klassen/Animal.gd")
const Tiger = preload("res://Klassen/Tiger.gd")
const Pinguin = preload("res://Klassen/Pinguin.gd")

func _ready():
	var animal = Animal.new("Hans")
	animal.shoutout()
	
	### dunno what here happening (why error that he need 1 param if he got 1)###
	
	#var tiger = Tiger.new("Mewie")
	#tiger.shoutout()
	
	#var pinguin = Pinguin.new("Happy")
	#pinguin.shoutout()
	
	get_tree().change_scene("res://Game.tscn")