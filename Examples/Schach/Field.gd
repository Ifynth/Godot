extends Node

const INIT_FIELD = [
["ST1","SS1","SL1","SK1","SD1","SL2","SS2","ST2"],
["SB1","SB2","SB3","SB4","SB5","SB6","SB7","SB8"],
["","","","","","","",""],
["","","","","","","",""],
["","","","","","","",""],
["","","","","","","",""],
["WB1","WB2","WB3","WB4","WB5","WB6","WB7","WB8"],
["WT1","WS1","WL1","WK1","WD1","WL2","WS2","WT2"]
]
# SIDE [TOP, BOTTOM], FIG [Bauer, Turm, Springer, Lauefer, Koenig, Dame]
const SIDE = ["Schwarz", "Weiß"]
const FIG = ["Bauer", "Turm", "Springer", "Läufer", "König", "Dame"]
const SPALTEN = ["a", "b", "c", "d", "e", "f", "g", "h"]

var FIELD = INIT_FIELD
var cursor
var img_size

# Variablen fürs Aufheben der Figuren und Ablegen an ihre jeweiligen Posiontion

var picked_up
var picked_up_node
# noch für Verbesserung offen nicht das er es ablegt und instant wieder aufnimmt
var picked_up_reminder
var gameOver

var turn

func _ready():
	
	cursor = get_node("Cursor")
	img_size = get_node("Cursor/img").get_texture().get_size().x
	picked_up = ""
	picked_up_node = Node2D
	picked_up_reminder = true
	gameOver = false
	
	# set Textures (imges for the figures)
	for side in SIDE:
		for fig in FIG:
			for color in get_node(side).get_children():
				if color.get_name()[0] == fig[0]:
					color.get_child(0).set_texture(load("img/"+side+"/"+fig+".png"))
	
	#0 -> black #1 -> white
	turn = 1
	print("Weiß beginnt, Schwarz gewinnt")
	
	set_process_input(true)
	

func _input(event):
	
	# 08/15 Moving Cursor
	if event.is_action_pressed("ui_up") and cursor.get_pos().y > img_size/2:
		cursor.set_pos(Vector2(cursor.get_pos().x, cursor.get_pos().y - img_size))
	
	if event.is_action_pressed("ui_left") and cursor.get_pos().x > img_size:
		cursor.set_pos(Vector2(cursor.get_pos().x - img_size, cursor.get_pos().y))
	
	if event.is_action_pressed("ui_right") and cursor.get_pos().x < OS.get_window_size().x - img_size/2:
		cursor.set_pos(Vector2(cursor.get_pos().x + img_size, cursor.get_pos().y))
	
	if event.is_action_pressed("ui_down") and cursor.get_pos().y < OS.get_window_size().y - img_size/2:
		cursor.set_pos(Vector2(cursor.get_pos().x, cursor.get_pos().y + img_size))
	
	#----------------------------------------------------------------------------------------------------------------------------
	
	# Spieler legt die Figur
	if event.is_action_pressed("ui_accept") and picked_up != "": 
		if FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)].length() > 1 and FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)][0] == picked_up[0] and FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)] != picked_up:
			print("Friendly Fire: OFF\nNimm erneut eine Figur")
		elif picked_up[1] == "B" and !is_BauerMovement_allowed(picked_up_node.get_pos(), cursor.get_pos(), picked_up):
			print("Bauer kann sich nicht so bewegen\nNimm erneut eine Figur")
		elif picked_up[1] == "T" and !is_TurmMovement_allowed(picked_up_node.get_pos(), cursor.get_pos()):
			print("Turm kann sich nicht so bewegen\nNimm erneut eine Figur")
		elif picked_up[1] == "S" and !is_SpringerMovement_allowed(picked_up_node.get_pos(), cursor.get_pos()):
			print("Springer kann sich nicht so bewegen\nNimm erneut eine Figur")
		elif picked_up[1] == "L" and !is_LaueferMovement_allowed(picked_up_node.get_pos(), cursor.get_pos()):
			print("Läufer kann sich nicht so bewegen\nNimm erneut eine Figur")
		# Missing !XOR :'(
		elif picked_up[1] == "D" and ( (!is_TurmMovement_allowed(picked_up_node.get_pos(), cursor.get_pos()) and !is_LaueferMovement_allowed(picked_up_node.get_pos(), cursor.get_pos())) or ((is_TurmMovement_allowed(picked_up_node.get_pos(), cursor.get_pos()) and is_LaueferMovement_allowed(picked_up_node.get_pos(), cursor.get_pos())))):
			print("Dame kann sich nicht so bewegen\nNimm erneut eine Figur")
		elif picked_up[1] == "K" and !is_KoenigMovement_allowed(picked_up_node.get_pos(), cursor.get_pos()):
			print("König kann sich nicht so bewegen\nNimm erneut eine Figur")
		else:
			# Node that got beaten up
			var del_node
			var fig_beaten
			var text = ""
			
			# Deleting Sprite from node 
			# Für Verbesserung offen z.B. Opacity
			for side in SIDE:
				for fig in FIG:
					for i in range(8,0,-1):
						if FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)] == side[0]+fig[0]+String(i) and picked_up != side[0]+fig[0]+String(i):
							del_node = get_node(side+"/"+fig+String(i))
							del_node.remove_child(del_node.get_child(0))
							fig_beaten = FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)]
			
			if FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)] != picked_up:
				turn +=1
				turn %= 2
			FIELD[getPos(picked_up_node.get_pos().y)][getPos(picked_up_node.get_pos().x)] = ""
			picked_up_node.set_pos(cursor.get_pos())
			if fig_beaten:
				for side in SIDE:
					for fig in FIG:
						if side[0] == fig_beaten[0] and fig[0] == fig_beaten[1]:
							text = " und besiegte den " + side + "en " + fig
			print("Auf " + SPALTEN[getPos(picked_up_node.get_pos().x)] + String(getPos(picked_up_node.get_pos().y) + 1) + text)
			FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)] = picked_up
		
		# switch turn
		if turn == 0:
			print("Schwarz ist am Zug!")
		else:
			print("Weiß ist am Zug!")
		
		picked_up = ""
		picked_up_reminder = false
	
	#----------------------------------------------------------------------------------------------------------------------------
	
	# Spieler nimmt die Figur
	if event.is_action_pressed("ui_accept") and picked_up == "" and picked_up_reminder and !gameOver:
		picked_up = FIELD[getPos(cursor.get_pos().y)][getPos(cursor.get_pos().x)]
		
		var print_text = ""
		
		# Figuren Abfragen
		for side in SIDE:
			for fig in FIG:
				for i in range(8,0,-1):
					if picked_up == side[0]+fig[0]+String(i):
						picked_up_node = get_node(side+"/"+fig+String(i))
						print_text = side + "er " + fig + " von " + SPALTEN[getPos(picked_up_node.get_pos().x)] + String(getPos(picked_up_node.get_pos().y) + 1)
		
		if picked_up.length() > 0 and (picked_up[0] == "W" and turn == 0 or picked_up[0] == "S" and turn == 1):
			picked_up = ""
			picked_up_node = Node2D
			print_text = ""
		
		print(print_text)
	
	# Nachschauen wer gewonnen hat
	
	var black_lost = true
	var white_lost = true
	
	for row in FIELD:
		for elem in row:
			if elem == "SK1":
				black_lost = false
			elif elem == "WK1":
				white_lost = false
	
	if black_lost and !gameOver:
		print("Weiß gewinnt!!")
		gameOver = true
	elif white_lost and !gameOver:
		print("Schwarz gewinnt!!")
		gameOver = true
	
	picked_up_reminder = true
	

#--------------------------------------------------<    FUNCTIONS    >-----------------------------------------------------------

# Berechnet den zu kriegenden Position (für img passende Felder)
func getPos(value):
	return (value - img_size/2) / img_size


# Berechnet die Position wo die einzelnen Figuren hingehören (z.B. Neu auflegen der Figuren durch FIELD)
# ZURZEIT KEINE VERWENDUNG
func makePos(vec2):
	return Vector2((vec2.x*img_size) - img_size/2, (vec2.y*img_size) - img_size/2)

#----------------------------------------------<    Movement allowed    >----------------------------------------------------


func is_BauerMovement_allowed(pos, goTo, fig):
	if pos == goTo:
		return true
	
	if fig.length() > 2 and fig[0] == "S":
		# Beat Someone
		if FIELD[getPos(goTo.y)][getPos(goTo.x)] != "" and  getPos(pos.y) - getPos(goTo.y) == -1 and abs(getPos(goTo.x)-getPos(pos.x)) == 1:
			return true
		# Not allowed to pass through straight if someone is infront
		if FIELD[getPos(goTo.y)][getPos(goTo.x)] != "":
			return false
		# Normally Movement
		if getPos(goTo.y) - getPos(pos.y) == 1 and pos.x == goTo.x:
			return true
		# First Movement
		if pos.y == 96 and getPos(goTo.y) - getPos(pos.y) == 2 and pos.x == goTo.x and FIELD[getPos(goTo.y)-1][getPos(goTo.x)] == "":
			return true
		
	elif fig.length() > 2 and  fig[0] == "W":
		# Beat Someone
		if FIELD[getPos(goTo.y)][getPos(goTo.x)] != "" and  getPos(pos.y) - getPos(goTo.y) == 1 and abs(getPos(goTo.x)-getPos(pos.x)) == 1:
			return true
		# Not allowed to pass through straight if someone is infront
		if FIELD[getPos(goTo.y)][getPos(goTo.x)] != "":
			return false
		# Normally Movement
		if getPos(pos.y) - getPos(goTo.y) == 1 and pos.x == goTo.x:
			 return true
		# First Movement
		if pos.y == 416 and getPos(pos.y) - getPos(goTo.y) == 2 and pos.x == goTo.x and FIELD[getPos(goTo.y)+1][getPos(goTo.x)] == "":
			return true
	
	return false


func is_TurmMovement_allowed(pos, goTo):
	#  Noch zu Testen
	### ---<   Kollidieren   >---
	var multi = 1
	var pos_change = pos.x
	var goTo_change = goTo.x
	
	if pos.x == goTo.x:
		pos_change = pos.y
		goTo_change = goTo.y
	
	if goTo_change < pos_change:
		multi = -1
	
	for i in range(1, abs(getPos(pos_change) - getPos(goTo_change)),1):
		if pos.x == goTo.x and FIELD[getPos(pos.y)+i*multi][getPos(pos.x)] != "":
			return false
		elif pos.x != goTo.x and FIELD[getPos(pos.y)][getPos(pos.x)+i*multi] != "":
			return false
	
	"""
	# Funkt Already but try to getting it smaller (top is smaller vers.)
	### ---<   Kollidieren   >---
	# Bewegung nach Oben
	if pos.x == goTo.x and pos.y != goTo.y and goTo.y < pos.y:
		for i in range(1,abs(getPos(pos.y) - getPos(goTo.y)),1):
			if FIELD[getPos(pos.y)-i][getPos(pos.x)] != "":
				return false
	
	# Bewegung nach Unten
	if pos.x == goTo.x and pos.y != goTo.y and goTo.y > pos.y:
		for i in range(1,abs(getPos(goTo.y) - getPos(pos.y)),1):
			if FIELD[getPos(pos.y)+i][getPos(pos.x)] != "":
				return false
	
	# Bewegung nach Links
	if pos.x != goTo.x and pos.y == goTo.y and goTo.x < pos.x :
		for i in range(1,abs(getPos(goTo.x) - getPos(pos.x)),1):
			if FIELD[getPos(pos.y)][getPos(pos.x)-i] != "":
				return false
	
	# Bewegung nach Links
	if pos.x != goTo.x and pos.y == goTo.y and goTo.x > pos.x :
		for i in range(1,abs(getPos(pos.x) - getPos(goTo.x)),1):
			if FIELD[getPos(pos.y)][getPos(pos.x)+i] != "":
				return false
	"""
	
	if (pos.x == goTo.x and pos.y != goTo.y) or (pos.x != goTo.x and pos.y == goTo.y) or (pos == goTo):
		return true
	return false

func is_SpringerMovement_allowed(pos, goTo):
	if pos == goTo:
		return true
	
	if abs(getPos(pos.x) - getPos(goTo.x)) + abs(getPos(pos.y) - getPos(goTo.y)) == 3 and pos.x != goTo.x and pos.y != goTo.y:
		return true
	
	return false

func is_LaueferMovement_allowed(pos, goTo):
	#  Noch zu Testen
	### ---<   Kollidieren   >---
	var multi_x = 1
	var multi_y = 1
	
	if getPos(goTo.x) - getPos(pos.x) < 0:
		multi_x = -1
	
	if getPos(goTo.y) - getPos(pos.y) < 0:
		multi_y = -1
	
	for i in range(1, abs(getPos(goTo.x) - getPos(pos.x)), 1):
		if FIELD[getPos(pos.y)+i*multi_y][getPos(pos.x)+i*multi_x] != "":
			return false
	
	"""
	# Funkt Already but try to getting it smaller (top is smaller vers.)
	### ---<   Kollidieren   >---
	# Bewegung nach rechts oben
	if getPos(goTo.x) - getPos(pos.x) > 0 and getPos(goTo.y) - getPos(pos.y) < 0:
		for i in range(1,abs(getPos(goTo.x) - getPos(pos.x)), 1):
			if FIELD[getPos(pos.y)-i][getPos(pos.x)+i] != "":
				return false
	
	# Bewegung nach rechts unten
	if getPos(goTo.x) - getPos(pos.x) > 0 and getPos(goTo.y) - getPos(pos.y) > 0:
		for i in range(1,abs(getPos(goTo.x) - getPos(pos.x)), 1):
			if FIELD[getPos(pos.y)+i][getPos(pos.x)+i] != "":
				return false
	
	# Bewegung nach links unten
	if getPos(goTo.x) - getPos(pos.x) < 0 and getPos(goTo.y) - getPos(pos.y) > 0:
		for i in range(1, abs(getPos(goTo.x) - getPos(pos.x)), 1):
			if FIELD[getPos(pos.y)-i][getPos(pos.x)+i] != "":
				return false
	
	# Bewegung nach links oben
	if getPos(goTo.x) - getPos(pos.x) < 0 and getPos(goTo.y) - getPos(pos.y) < 0:
		for i in range(1, abs(getPos(goTo.x) - getPos(pos.x)), 1):
			if FIELD[getPos(pos.y)-i][getPos(pos.x)-i] != "":
				return false
	"""
	
	if pos == goTo or (abs(getPos(goTo.x)-getPos(pos.x)) == abs(getPos(goTo.y)-getPos(pos.y))):
		return true
	return false

func is_KoenigMovement_allowed(pos, goTo):
	if pos == goTo:
		return true
	
	if abs(getPos(pos.x) - getPos(goTo.x)) < 2 and abs(getPos(pos.y) - getPos(goTo.y)) < 2:
		return true
	
	return false
