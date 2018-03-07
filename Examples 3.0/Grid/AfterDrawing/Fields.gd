extends Sprite

export(int) var width = 10
export(int) var height = 6
export(int) var size = 64

signal delete_field

var draw_field
var fields = []

func _draw():
	if draw_field:
		for pos in fields:
			draw_rect(Rect2(pos*size, Vector2(size,size)), "#00cc00")
	

func drawField(pos, step):
	removeField()
	
	get_fields(pos, step, fields)
	
	draw_field = true
	update()

func removeField():
	emit_signal("delete_field")
	fields = []
	draw_field = false
	update()

func get_fields(pos, step, finarr):
	if finarr.find(pos) == -1:
		finarr.append(pos)
	
	#top
	if step > 0 and pos.y - 1 >= 0:
		get_fields(Vector2(pos.x, pos.y-1), step-1, finarr)
	
	#left
	if step > 0 and pos.x - 1 >= 0:
		get_fields(Vector2(pos.x-1, pos.y), step-1, finarr)
	
	#right
	if step > 0 and pos.x + 1 < width:
		get_fields(Vector2(pos.x+1, pos.y), step-1, finarr)
	
	#bottom
	if step > 0 and pos.y + 1 < height:
		get_fields(Vector2(pos.x, pos.y+1), step-1, finarr)
	
