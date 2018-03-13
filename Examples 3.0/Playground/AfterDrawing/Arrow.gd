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
		createHead(false, -1)
	# Left
	if before.x >= after.x and before.y == after.y:
		createHead(true, -1)
	# Right
	if before.x <= after.x and before.y == after.y:
		createHead(true, 1)
	# Bottom
	if before.x == after.x and before.y <= after.y:
		createHead(false, 1)
	

func createHead(horizontal, flip, start = 10, ankle = 5, arrow_point = 15):
	# horizontal -> True: Left, Right | False: Top, Bottom
	# flip: 1 -> z.B. Right, Bottom | -1 -> z.B. Left, Top
	
	# Setting Start Points
	var x = after.x + smallE
	var y = after.y + smallE
	if flip == -1 and !horizontal: y = after.y + bigE #Top
	if flip == -1 and horizontal: x = after.x + bigE #Left
	
	if horizontal:
		draw_line(Vector2(x,y), Vector2(x + start * flip, y), color, thick); x += start * flip
		draw_line(Vector2(x,y), Vector2(x, y - ankle), color, thick); y -= ankle
		draw_line(Vector2(x,y), Vector2(x + arrow_point * flip, after.y + size/2), color, thick); x += arrow_point * flip; y = after.y + size/2
		draw_line(Vector2(x,y), Vector2(x - arrow_point * flip, after.y + bigE + ankle), color, thick); x -= arrow_point * flip; y = after.y + bigE + ankle
		draw_line(Vector2(x,y), Vector2(x, y - ankle), color, thick); y -= ankle
		draw_line(Vector2(x,y), Vector2(x - start * flip, y), color, thick);
	else:
		draw_line(Vector2(x,y), Vector2(x, y + start * flip), color, thick); y += start * flip
		draw_line(Vector2(x,y), Vector2(x - ankle, y), color, thick); x -= ankle
		draw_line(Vector2(x,y), Vector2(after.x + size/2, y + arrow_point * flip), color, thick); x = after.x + size/2; y += arrow_point * flip
		draw_line(Vector2(x,y), Vector2(after.x + bigE + ankle, y - arrow_point * flip), color, thick); x = after.x + bigE + ankle; y -= arrow_point * flip
		draw_line(Vector2(x,y), Vector2(x - ankle, y), color, thick); x -= ankle
		draw_line(Vector2(x,y), Vector2(x, y - start * flip), color, thick);
	

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
	
