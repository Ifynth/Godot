extends Sprite

export var fieldstart = Vector2(0,0)
export var fieldsizeX = 0
export var fieldsizeY = 0

signal moved

var size = 64
var ex_field = []

func _input(event):
	
	if event.is_action("ui_up") and !event.is_action_released("ui_up") and checkNext(Vector2(position.x,position.y - size)):
		position.y -= size
		handleMove()
	elif event.is_action("ui_left") and !event.is_action_released("ui_left") and checkNext(Vector2(position.x - size,position.y)):
		position.x -= size
		handleMove()
	elif event.is_action("ui_right") and !event.is_action_released("ui_right") and checkNext(Vector2(position.x + size,position.y)):
		position.x += size
		handleMove()
	elif event.is_action("ui_down") and !event.is_action_released("ui_down") and checkNext(Vector2(position.x,position.y + size)):
		position.y += size
		handleMove()
	

func handleMove():
	emit_signal("moved")
	$AnimationPlayer.play("Default")

func checkNext(target):
	# onlyMoveOnExField allows the Cursor to only move inside the new generated field
	return inSideField(target) #and onlyMoveOnExField(target)

func inSideField(target):
	if !fieldsizeX or !fieldsizeY:
		print("xxx Cursor Scene don't know where to Move (Missing width/height) xxx")
		return false
	
	return (target.x >= fieldstart.x and target.x <= fieldsizeX * size) \
		and (target.y >= fieldstart.y and target.y <= fieldsizeY * size)
	

func onlyMoveOnExField(target):
	# if there is no extra field there is no problem
	if !ex_field:
		return true
	
	for field in ex_field:
		if target.x == field.x * size and target.y == field.y * size:
			return true
	
	return false

func deleteField():
	ex_field = []
	
