extends Sprite

enum {TOP, LEFT, RIGHT, BOTTOM}

var size = 64

var tail
var saved_body = []
var body = []

var before
var before_pos
var after
var after_pos

#xxxtestingxxx
var smallE = 22
var bigE = 42

# TODO 
# 	1. Recognise the 90 degree scheme
# 	2. Get the shortest Length
# 	3. Draw on Command

func _draw():
	# Only Draw lenght 2 (no drawing if there is only a tail)
	if saved_body.size() > 1:
		print("body full, ready to draw")
		generateTail()
		generateBody()
		generateHead()

func createArrow(pos):
	tail = pos;
	saved_body.append(pos)
	

func delArrow():
	tail = null
	saved_body = []

func addBody(pos):
	# Check if the pos isn't in Arrow - Line
	
	if saved_body.size() != 0:
		# vergleiche alte Position mit der neuen Position
		if saved_body[saved_body.size()-1].y > pos.y:
			body.append(TOP)
		elif saved_body[saved_body.size()-1].x > pos.x:
			body.append(LEFT)
		elif saved_body[saved_body.size()-1].x < pos.x:
			body.append(RIGHT)
		elif saved_body[saved_body.size()-1].y < pos.y:
			body.append(BOTTOM)
		saved_body.append(pos)
	print("Saved: ", saved_body)
	print("Body: ", body)
	
	if saved_body.size() > 1:
		update()

func generateTail():
	after = body[0] #HACK to know where is next #body.pop_front()
	after_pos = tail
	if after != TOP: draw_line(Vector2(tail.x+smallE, tail.y+smallE), Vector2(tail.x+bigE, tail.y+smallE), "#ffffff")
	if after != LEFT: draw_line(Vector2(tail.x+smallE, tail.y+smallE), Vector2(tail.x+smallE, tail.y+bigE), "#ffffff")
	if after != RIGHT: draw_line(Vector2(tail.x+bigE, tail.y+smallE), Vector2(tail.x+bigE, tail.y+bigE), "#ffffff")
	if after != BOTTOM: draw_line(Vector2(tail.x+smallE, tail.y+bigE), Vector2(tail.x+bigE, tail.y+bigE), "#ffffff")

func generateBody():
	#TODO zeichnet zurzeit nur 1x, muss öfters aufgerufen werden
	#if body.size() != 0:
	before = after
	before_pos = after_pos
	after = body[body.size()-1] #HACK
	match after:
		TOP: after_pos.y -= size
		LEFT: after_pos.x -= size
		RIGHT: after_pos.x += size
		BOTTOM: after_pos.y += size
	
	#Draw Body rect with holes
	#if after != TOP or before != TOP: draw_line(Vector2(tail.x+smallE, tail.y+smallE), Vector2(tail.x+bigE, tail.y+smallE), "#ffffff")
	#if after != LEFT or before != LEFT: draw_line(Vector2(tail.x+smallE, tail.y+smallE), Vector2(tail.x+smallE, tail.y+bigE), "#ffffff")
	#if after != RIGHT or before != RIGHT: draw_line(Vector2(tail.x+bigE, tail.y+smallE), Vector2(tail.x+bigE, tail.y+bigE), "#ffffff")
	#if after != BOTTOM or before != BOTTOM: draw_line(Vector2(tail.x+smallE, tail.y+bigE), Vector2(tail.x+bigE, tail.y+bigE), "#ffffff")
	
	#Row
	if (before == RIGHT and after == RIGHT) or (before == LEFT and after == LEFT):
		draw_line(Vector2(before_pos.x+bigE, before_pos.y+smallE), Vector2(after_pos.x+smallE, after_pos.y+smallE), "#ffffff")
		draw_line(Vector2(before_pos.x+bigE, before_pos.y+bigE), Vector2(after_pos.x+smallE, after_pos.y+bigE), "#ffffff")
	

func generateHead():
	# body should be empty
	# TODO Delete before ~Fin~
	#if body.size() != 0:
	#	print("xxx Body should be Empty [Arrow.gd] xxx")
	#	return false
	
	# TODO Recognise Scheme (90 degree)!!!
	if after == RIGHT:
		# Head (Right)
		draw_line(Vector2(after_pos.x+20, after_pos.y+22), Vector2(after_pos.x+30, after_pos.y+22), "#ffffff")
		draw_line(Vector2(after_pos.x+30, after_pos.y+22), Vector2(after_pos.x+30, after_pos.y+17), "#ffffff")
		draw_line(Vector2(after_pos.x+30, after_pos.y+17), Vector2(after_pos.x+45, after_pos.y+32), "#ffffff")
		draw_line(Vector2(after_pos.x+45, after_pos.y+32), Vector2(after_pos.x+30, after_pos.y+47), "#ffffff")
		draw_line(Vector2(after_pos.x+30, after_pos.y+47), Vector2(after_pos.x+30, after_pos.y+42), "#ffffff")
		draw_line(Vector2(after_pos.x+30, after_pos.y+42), Vector2(after_pos.x+20, after_pos.y+42), "#ffffff")
	
