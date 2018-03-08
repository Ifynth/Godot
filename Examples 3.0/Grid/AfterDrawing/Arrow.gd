extends Sprite

var size = 64
export var thick = 1.0
export var color = "#ffffff"
# export var arrowSize = 20

var smallE = 22 # 16
var bigE = 42 # 48

var arrow_line = []
var steps

var after
var before

func _draw():
	if arrow_line.size() > 1:
		# Only Draw if there are 2 
		drawTail()
		for i in range(1, arrow_line.size()):
			drawBody(i)
		drawHead()

func drawTail():
	after = arrow_line[0]
	if after.y <= arrow_line[1].y: draw_line(Vector2(after.x+smallE, after.y+smallE), Vector2(after.x+bigE, after.y+smallE), color, thick)
	if after.x <= arrow_line[1].x: draw_line(Vector2(after.x+smallE, after.y+smallE), Vector2(after.x+smallE, after.y+bigE), color, thick)
	if after.x >= arrow_line[1].x: draw_line(Vector2(after.x+bigE, after.y+smallE), Vector2(after.x+bigE, after.y+bigE), color, thick)
	if after.y >= arrow_line[1].y: draw_line(Vector2(after.x+smallE, after.y+bigE), Vector2(after.x+bigE, after.y+bigE), color, thick)

func drawBody(index):
	before = after
	after = arrow_line[index]
	
	# First Part
	# Top
	if before.x == after.x and before.y >= after.y:
		draw_line(Vector2(before.x+smallE, before.y+smallE), Vector2(after.x+smallE, after.y+bigE), color, thick)
		draw_line(Vector2(before.x+bigE, before.y+smallE), Vector2(after.x+bigE, after.y+bigE), color, thick)
	
	# Left
	if before.x >= after.x and before.y == after.y:
		draw_line(Vector2(before.x+smallE, before.y+smallE), Vector2(after.x+bigE, after.y+smallE), color, thick)
		draw_line(Vector2(before.x+smallE, before.y+bigE), Vector2(after.x+bigE, after.y+bigE), color, thick)
	
	# Right
	if before.x <= after.x and before.y == after.y:
		draw_line(Vector2(before.x+bigE, before.y+smallE), Vector2(after.x+smallE, after.y+smallE), color, thick)
		draw_line(Vector2(before.x+bigE, before.y+bigE), Vector2(after.x+smallE, after.y+bigE), color, thick)
	
	# Bottom
	if before.x == after.x and before.y <= after.y:
		draw_line(Vector2(before.x+smallE, before.y+bigE), Vector2(after.x+smallE, after.y+smallE), color, thick)
		draw_line(Vector2(before.x+bigE, before.y+bigE), Vector2(after.x+bigE, after.y+smallE), color, thick)
	
	# makes the pieces between
	if index + 1 != arrow_line.size():
		var next = arrow_line[index + 1]
		
		if !before.y < after.y and !after.y > next.y: draw_line(Vector2(after.x+smallE, after.y+smallE), Vector2(after.x+bigE, after.y+smallE), color, thick)
		if !before.x < after.x and !after.x > next.x: draw_line(Vector2(after.x+smallE, after.y+smallE), Vector2(after.x+smallE, after.y+bigE), color, thick)
		if !before.x > after.x and !after.x < next.x: draw_line(Vector2(after.x+bigE, after.y+smallE), Vector2(after.x+bigE, after.y+bigE), color, thick)
		if !before.y > after.y and !after.y < next.y: draw_line(Vector2(after.x+smallE, after.y+bigE), Vector2(after.x+bigE, after.y+bigE), color, thick)
	

func drawHead():
	# Top
	if before.x == after.x and before.y >= after.y:
		draw_line(Vector2(after.x+smallE, after.y+bigE), Vector2(after.x+smallE, after.y+bigE - 10), color, thick)
		draw_line(Vector2(after.x+smallE, after.y+bigE - 10), Vector2(after.x+smallE - 5, after.y+bigE - 10), color, thick)
		draw_line(Vector2(after.x+smallE - 5, after.y+bigE - 10), Vector2(after.x + size/2, after.y+bigE - 25), color, thick)
		draw_line(Vector2(after.x + size/2, after.y+bigE - 25), Vector2(after.x+bigE + 5, after.y+bigE - 10), color, thick)
		draw_line(Vector2(after.x+bigE + 5, after.y+bigE - 10), Vector2(after.x+bigE, after.y+bigE - 10), color, thick)
		draw_line(Vector2(after.x+bigE, after.y+bigE - 10), Vector2(after.x+bigE, after.y+bigE), color, thick)
	
	# Left
	if before.x >= after.x and before.y == after.y:
		draw_line(Vector2(after.x+bigE, after.y+smallE), Vector2(after.x+bigE - 10, after.y+smallE), color, thick)
		draw_line(Vector2(after.x+bigE - 10, after.y+smallE), Vector2(after.x+bigE - 10, after.y+smallE - 5), color, thick)
		draw_line(Vector2(after.x+bigE - 10, after.y+smallE - 5), Vector2(after.x+bigE - 25, after.y + size/2), color, thick)
		draw_line(Vector2(after.x+bigE - 25, after.y + size/2), Vector2(after.x+bigE - 10, after.y+bigE + 5), color, thick)
		draw_line(Vector2(after.x+bigE - 10, after.y+bigE + 5), Vector2(after.x+bigE - 10, after.y+bigE), color, thick)
		draw_line(Vector2(after.x+bigE - 10, after.y+bigE), Vector2(after.x+bigE, after.y+bigE), color, thick)
	
	# Right
	if before.x <= after.x and before.y == after.y:
		draw_line(Vector2(after.x+smallE, after.y+smallE), Vector2(after.x+smallE + 10, after.y+smallE), color, thick)
		draw_line(Vector2(after.x+smallE + 10, after.y+smallE), Vector2(after.x+smallE + 10, after.y+smallE - 5), color, thick)
		draw_line(Vector2(after.x+smallE + 10, after.y+smallE - 5), Vector2(after.x+smallE + 25, after.y + size/2), color, thick)
		draw_line(Vector2(after.x+smallE + 25, after.y + size/2), Vector2(after.x+smallE + 10, after.y+bigE + 5), color, thick)
		draw_line(Vector2(after.x+smallE + 10, after.y+bigE + 5), Vector2(after.x+smallE + 10, after.y+bigE), color, thick)
		draw_line(Vector2(after.x+smallE + 10, after.y+bigE), Vector2(after.x+smallE, after.y+bigE), color, thick)
	
	# Bottom
	if before.x == after.x and before.y <= after.y:
		draw_line(Vector2(after.x+smallE, after.y+smallE), Vector2(after.x+smallE, after.y+smallE + 10), color, thick)
		draw_line(Vector2(after.x+smallE, after.y+smallE + 10), Vector2(after.x+smallE - 5, after.y+smallE + 10), color, thick)
		draw_line(Vector2(after.x+smallE - 5, after.y+smallE + 10), Vector2(after.x + size/2, after.y+smallE + 25), color, thick)
		draw_line(Vector2(after.x + size/2, after.y+smallE + 25), Vector2(after.x+bigE + 5, after.y+smallE + 10), color, thick)
		draw_line(Vector2(after.x+bigE + 5, after.y+smallE + 10), Vector2(after.x+bigE, after.y+smallE + 10), color, thick)
		draw_line(Vector2(after.x+bigE, after.y+smallE + 10), Vector2(after.x+bigE, after.y+smallE), color, thick)
	

func createArrow(pos, steps):
	arrow_line.append(pos)
	self.steps = steps

func addBody(pos):
	# check if pos is in arrow_line
	var index = arrow_line.find(pos)
	if index != -1:
		arrow_line.resize(index + 1)
	else:
		# check if stepsize is reached
		if arrow_line.size() <= steps:
			arrow_line.append(pos)
		else:
			calcNewRoute(arrow_line[0], pos)
	
	update()

func delArrow():
	arrow_line = []
	update()

func calcNewRoute(start, goal):
	# start from beginning
	arrow_line.resize(1)
	while arrow_line[arrow_line.size() -1] != goal:
		# move first on x
		if arrow_line[arrow_line.size() -1].x < goal.x:
			arrow_line.append(Vector2(arrow_line[arrow_line.size() -1].x + size, arrow_line[arrow_line.size() -1].y))
		elif arrow_line[arrow_line.size() -1].x > goal.x:
			arrow_line.append(Vector2(arrow_line[arrow_line.size() -1].x - size, arrow_line[arrow_line.size() -1].y))
		# move then on y
		if arrow_line[arrow_line.size() -1].y < goal.y:
			arrow_line.append(Vector2(arrow_line[arrow_line.size() -1].x, arrow_line[arrow_line.size() -1].y + size))
		elif arrow_line[arrow_line.size() -1].y > goal.y:
			arrow_line.append(Vector2(arrow_line[arrow_line.size() -1].x, arrow_line[arrow_line.size() -1].y - size))
	
