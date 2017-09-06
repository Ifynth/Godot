extends Sprite

var grid

var width = 12
var height = 10

func _ready():
	grid = get_parent()

func _draw():
	# draw_line funkt erst ab vers. 3.0 bei export
	
	"""
	for x in range(width):
		for y in range(height):
			draw_line(grid.map_to_world(Vector2(x,y)), grid.map_to_world(Vector2(width-1, y)), Color("#ffffff"), 4.0)
			draw_line(grid.map_to_world(Vector2(x,y)), grid.map_to_world(Vector2(x, height-1)), Color("#ffffff"), 4.0)
	"""
	for i in range(height + 1):
		draw_rect(Rect2(i*64,0,1,height*64), Color("#ffffff"))
	
	for i in range(width + 1):
		draw_rect(Rect2(0,i *64,width*64, 1), Color("#ffffff")) 
