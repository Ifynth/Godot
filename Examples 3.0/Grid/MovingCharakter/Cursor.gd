extends Sprite

var size = 64

func _ready():
	pass

func _input(event):
	# moving
	if event.is_action("ui_up") and !event.is_action_released("ui_up"):
		position.y -= size
	elif event.is_action("ui_left") and !event.is_action_released("ui_left"):
		position.x -= size
	elif event.is_action("ui_right") and !event.is_action_released("ui_right"):
		position.x += size
	elif event.is_action("ui_down") and !event.is_action_released("ui_down"):
		position.y += size