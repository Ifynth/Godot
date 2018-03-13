extends Sprite

export(int) var width = 10
export(int) var height = 6
export(int) var size = 64

func _draw():
	for x in range(width + 1):
		draw_line(Vector2(x*size, 0), Vector2(x*size, height*size),"#ffffff",2)
	for y in range(height + 1):
		draw_line(Vector2(0, y*size), Vector2(width*size, y*size),"#ffffff",2)
	