extends Node

export var speed = 0.5

var index_text = 0
var index_text_max
var akt_text
var out_faded = false
var skip_open

func _ready():
	index_text_max = $Texte.get_children().size()
	getNextText()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if !skip_open:
			$SkipEnter.show()
			$SkipTimer.start()
			skip_open = true
		else:
			showEndScreen()

func _process(delta):
	# Switching Main Text
	if akt_text.visible and !out_faded and akt_text.modulate.a < 1:
		akt_text.modulate.a += delta * speed
	elif akt_text.visible and !out_faded and akt_text.modulate.a >= 1:
		out_faded = true
	
	if out_faded and akt_text.modulate.a > 0:
		akt_text.modulate.a -= delta * speed
	elif out_faded and akt_text.modulate.a <= 0:
		getNextText()
		out_faded = false
	
	# Skip button
	if skip_open and $SkipTimer.time_left == 0 and $SkipEnter.modulate.a > 0:
		$SkipEnter.modulate.a -= delta * speed
	elif skip_open and $SkipTimer.time_left == 0 and $SkipEnter.modulate.a <= 0:
		$SkipEnter.hide()
		$SkipEnter.modulate.a = 1
		skip_open = false
	

func getNextText():
	if index_text < index_text_max:
		akt_text = $Texte.get_child(index_text)
		akt_text.modulate.a = 0
		print(akt_text.modulate.a)
		akt_text.show()
	else:
		set_process(false)
	
	index_text += 1

func showEndScreen():
	get_tree().change_scene("res://Game.tscn")