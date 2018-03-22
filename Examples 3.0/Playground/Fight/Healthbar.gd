extends Control

var max_width = 20
var hp

# Have to been used!
func createPoints(hp, between = Vector2(7, 26)):
	var next_pos = Vector2(0,0)
	self.hp = hp
	
	while hp > 0:
		addHealthPoint(next_pos)
		next_pos.x += between.x
		if next_pos.x >= between.x * max_width:
			next_pos = Vector2(0,next_pos.y + between.y)
		hp -= 1

func addHealthPoint(pos):
	var point = load("res://Fight/HealthPoint.tscn").instance()
	point.position = pos
	add_child(point)

func takeDmg(hp):
	while hp > 0:
		removeHealthPoint()
		hp -= 1

func removeHealthPoint():
	get_child(hp - 1).loseHp()
	hp -= 1