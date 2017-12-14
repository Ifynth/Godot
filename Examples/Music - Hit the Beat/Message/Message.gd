extends Sprite

var timer

func _ready():
	timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_timout")
	timer.start()
	set_process(true)

func _process(delta):
	if timer.get_time_left() <= 0.5:
		set_opacity(timer.get_time_left() * 2)
	else:
		set_opacity(2.0 - timer.get_time_left() * 2)

func _on_Timer_timout():
	queue_free()

func changeSprite(name):
	set_texture(load("res://Message/" + name + ".png"))