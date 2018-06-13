extends Path2D

export(int) var speed = 200

func _ready():
	$Tween.interpolate_property($PathFollow2D, "unit_offset", 0, 1, 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	$Tween.start();

func _process(delta):
	#$PathFollow2D.offset += speed * delta
	pass
