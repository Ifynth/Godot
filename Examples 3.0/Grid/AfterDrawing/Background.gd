extends Sprite

export(int) var width = 10
export(int) var height = 6
export(int) var size = 64

var draw_field
var fields = []

func _draw():
	if draw_field:
		for pos in fields:
			draw_rect(Rect2(pos, Vector2(size,size)), "#00cc00")
	
	for x in range(width + 1):
		draw_line(Vector2(x*size, 0), Vector2(x*size, height*size),"#ffffff",2)
	for y in range(height + 1):
		draw_line(Vector2(0, y*size), Vector2(width*size, y*size),"#ffffff",2)
	

func drawField(pos, step):
	removeField()
	print("Draw")
	print("Pos: ", pos)
	print("Move: ", step)
	
	get_fields(pos, step, fields)
	
	draw_field = true
	update()

func removeField():
	print("Löschen")
	fields = []
	draw_field = false
	update()

func get_fields(pos, step, finarr):
	if finarr.find(pos) == -1:
		finarr.append(pos)
	
	#top
	if step > 0:
		get_fields(Vector2(pos.x, pos.y-1), step-1, finarr)
	
	#left
	if step > 0:
		get_fields(Vector2(pos.x-1, pos.y), step-1, finarr)
	
	#right
	if step > 0:
		get_fields(Vector2(pos.x+1, pos.y), step-1, finarr)
	
	#bottom
	if step > 0:
		get_fields(Vector2(pos.x, pos.y+1), step-1, finarr)
	
