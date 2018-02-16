extends Sprite

var size = 64

#FIXME
var fieldstart
var fieldsizeX
var fieldsizeY

func _input(event):
	
	if event.is_action("ui_up") and !event.is_action_released("ui_up") and inSideField(Vector2(position.x,position.y - size)):
		position.y -= size
		$AnimationPlayer.play("Default")
	elif event.is_action("ui_left") and !event.is_action_released("ui_left") and inSideField(Vector2(position.x - size,position.y)):
		position.x -= size
		$AnimationPlayer.play("Default")
	elif event.is_action("ui_right") and !event.is_action_released("ui_right") and inSideField(Vector2(position.x + size,position.y)):
		position.x += size
		$AnimationPlayer.play("Default")
	elif event.is_action("ui_down") and !event.is_action_released("ui_down") and inSideField(Vector2(position.x,position.y + size)):
		position.y += size
		$AnimationPlayer.play("Default")

func inSideField(target):
	# FIXME
	if !fieldstart or !fieldsizeX or !fieldsizeY:
		print("xxx Cursor Scene don't know where to Move xxx")
		return false
	
	return (target.x >= fieldstart.x and target.x <= fieldsizeX * size) and (target.y >= fieldstart.y and target.y <= fieldsizeY * size)
	
