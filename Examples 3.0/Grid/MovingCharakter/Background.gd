 extends Sprite

var width = 16
var height = 9
var size = 64

func _draw():
	for x in range(width + 1):
		draw_line(Vector2(x*size, 0), Vector2(x*size, height*size),"#ffffff",2)
	for y in range(height + 1):
		draw_line(Vector2(0, y*size), Vector2(width*size, y*size),"#ffffff",2)
	

func draw_moving(pos, rang):
	draw_line(pos, pos*2, "#ffff00", 4)
	print(pos)
	print(rang)
