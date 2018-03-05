extends Sprite

enum {TOP, LEFT, RIGHT, BOTTOM}

var size = 64

var tail = Vector2(0,0)
var body = []
var head = Vector2(64,0)

var before
var after

# TODO 
# 	1. Recognise the 90 degree scheme
# 	2. Get the shortest Length
# 	3. Draw on Command

func _init():
	# Only for testing!
	body.append(RIGHT)
	body.append(RIGHT)

func _draw():
	generateTail()
	generateBody()
	generateHead()

func generateTail():
	after = body.pop_front() #to know where is next
	if after != TOP: draw_line(Vector2(tail.x+20, tail.y+20), Vector2(tail.x+40, tail.y+20), "#ffffff")
	if after != LEFT: draw_line(Vector2(tail.x+20, tail.y+20), Vector2(tail.x+20, tail.y+40), "#ffffff")
	if after != RIGHT: draw_line(Vector2(tail.x+40, tail.y+20), Vector2(tail.x+40, tail.y+40), "#ffffff")
	if after != BOTTOM: draw_line(Vector2(tail.x+20, tail.y+40), Vector2(tail.x+40, tail.y+40), "#ffffff")

func generateBody():
	print(body.size())
	if body.size() != 0:
		before = after
		after = body.pop_front()
	
	#Row
	if (before == RIGHT and after == RIGHT) or (before == LEFT and after == LEFT):
		draw_line(Vector2(tail.x+40, tail.y+20), Vector2(head.x+20, head.y+20), "#ffffff")
		draw_line(Vector2(tail.x+40, tail.y+40), Vector2(head.x+20, head.y+40), "#ffffff")
	
	pass
	

func generateHead():
	# body should be empty
	# TODO Delete before ~Fin~ (only func)
	if body.size() != 0:
		print("xxx Body should be here Empty [Arrow.gd] xxx")
		return false
	
	# TODO Recognise Scheme (90 degree)!!!
	if after == RIGHT:
		# Head (Right)
		draw_line(Vector2(head.x+20, head.y+20), Vector2(head.x+30, head.y+20), "#ffffff")
		draw_line(Vector2(head.x+30, head.y+20), Vector2(head.x+30, head.y+15), "#ffffff")
		draw_line(Vector2(head.x+30, head.y+15), Vector2(head.x+45, head.y+30), "#ffffff")
		draw_line(Vector2(head.x+45, head.y+30), Vector2(head.x+30, head.y+45), "#ffffff")
		draw_line(Vector2(head.x+30, head.y+45), Vector2(head.x+30, head.y+40), "#ffffff")
		draw_line(Vector2(head.x+30, head.y+40), Vector2(head.x+20, head.y+40), "#ffffff")