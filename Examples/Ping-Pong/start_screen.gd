extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	get_node("Game_start").connect("pressed", self, "start")
	

func start():
	get_tree().change_scene("res://pong.tscn")