extends Sprite

var fill = "#092"

func _draw():
	# white background
	draw_circle(Vector2(position.x + 10, position.y + 6.25), 4.75, "#fff")
	draw_rect(Rect2(position.x + 6.25, position.y + 6.25, 8, 37.5), "#fff")
	draw_circle(Vector2(position.x + 10, position.y + 43.75), 4.75, "#fff")
	
	# green inside
	draw_circle(Vector2(position.x + 10, position.y + 6.25), 3.25, fill)
	draw_rect(Rect2(position.x + 6.75, position.y + 8.25, 6.5, 35.5), fill)
	draw_circle(Vector2(position.x + 10, position.y + 43.75), 3.25, fill)

func loseHp():
	fill =  "4c4c4c"
	update()