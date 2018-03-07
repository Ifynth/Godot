extends Sprite

var size = 64

var arrow_line = []
var steps

func _draw():
	if arrow_line.size() > 1:
		# Only Draw if there are 2 
		pass

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
	print("new Route: ", arrow_line)
