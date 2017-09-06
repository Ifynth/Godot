extends Sprite

var color = Color("#00DD00")
var fields = []

func _ready():
	pass

func _draw():
	for rect in fields:
		draw_rect(rect, color)

func set_fields(posarr, size):
	for pos in posarr:
		fields.append(Rect2(Vector2(pos.x+2, pos.y+2), size))

func set_color(col):
	color = Color(col)