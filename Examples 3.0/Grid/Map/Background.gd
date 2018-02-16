 extends Sprite

var width = 14
var height = 7
var size = 64

func _draw():
	for x in range(width + 1):
		draw_line(Vector2(x*size, 0), Vector2(x*size, height*size),"#ffffff")
	for y in range(height + 1):
		draw_line(Vector2(0, y*size), Vector2(width*size, y*size),"#ffffff")