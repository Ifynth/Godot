extends Sprite

var size = 64

var tail = Vector2(0,0)
var body = []
var head = Vector2(64,0)


func _draw():
	
	#Tail
	draw_line(Vector2(tail.x+20, tail.y+20), Vector2(tail.x+40, tail.y+20), "#ffffff")
	draw_line(Vector2(tail.x+20, tail.y+20), Vector2(tail.x+20, tail.y+40), "#ffffff")
	# draw_line(Vector2(tail.x+40, tail.y+20), Vector2(tail.x+40, tail.y+40), "#ffffff")
	draw_line(Vector2(tail.x+20, tail.y+40), Vector2(tail.x+40, tail.y+40), "#ffffff")
	
	#Head (right)
	draw_line(Vector2(head.x+20, head.y+20), Vector2(head.x+30, head.y+20), "#ffffff")
	draw_line(Vector2(head.x+30, head.y+20), Vector2(head.x+30, head.y+15), "#ffffff")
	draw_line(Vector2(head.x+30, head.y+35), Vector2(head.x+35, head.y+35), "#ffffff")