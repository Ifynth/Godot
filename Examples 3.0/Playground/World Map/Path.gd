extends Path2D

# D - Direction
enum D { DEFAULT, UP, LEFT, RIGHT, DOWN }
export (D) var direction = D.DEFAULT
export(int) var speed = 4 # 1 === rly fast

func start_tween():
	$Tween.interpolate_property($Follow, "unit_offset", 0, 1, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	$Tween.start();

func get_follow_pos():
	return $Follow.position