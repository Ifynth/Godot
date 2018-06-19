extends Sprite

export var can_pickup = false
export var fieldstart = Vector2(0,0)
export var fieldsizeX = 0
export var fieldsizeY = 0

signal moved # TODO find ref. where/why do I needed that for???
signal picked_up

var size = 64
var ex_field = []

# States:
# 	Default -> Moving
# 	Picked_up -> a Charakter is Binded on the Cursor
enum states {DEFAULT, PICKED_UP}
var state = DEFAULT

func _input(event):
	# Handle Movement
	if event.is_action("ui_up") and !event.is_action_released("ui_up") and checkNext(Vector2(position.x,position.y - size)):
		position.y -= size
		handleMove()
	if event.is_action("ui_left") and !event.is_action_released("ui_left") and checkNext(Vector2(position.x - size,position.y)):
		position.x -= size
		handleMove()
	if event.is_action("ui_right") and !event.is_action_released("ui_right") and checkNext(Vector2(position.x + size,position.y)):
		position.x += size
		handleMove()
	if event.is_action("ui_down") and !event.is_action_released("ui_down") and checkNext(Vector2(position.x,position.y + size)):
		position.y += size
		handleMove()
	
	# Handle Pick up
	if event.is_action_pressed("ui_accept") and can_pickup:
		match(state):
			DEFAULT:
				handleDefaultInput()
			PICKED_UP:
				handlePickedUpInput()

func handleMove():
	emit_signal("moved")
	$AnimationPlayer.play("Default")

func checkNext(target):
	# onlyMoveOnExField allows the Cursor to only move inside the new generated field
	return inSideField(target) #and onlyMoveOnExField(target)

func inSideField(target):
		# if there is no Field he is allowed to move he can move everywhere
	if !fieldsizeX or !fieldsizeY:
		return true
	
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
	

# Pick up Handler's
func handleDefaultInput():
	print("Pick up")
	# picked_up = node
	state = PICKED_UP
	

func handlePickedUpInput():
	print("Drop")
	# picked_up = null
	state = DEFAULT