extends Sprite

export(int) var movement_range = 3
export(int) var attack_range = 1

export(int) var LP = 10
export(int) var ATK = 3
export(int) var DEF = 1
export(int) var EXP = 0

var akt_LP = LP

func resetStats():
	akt_LP = LP

func takeDamage(dmg):
	if dmg - DEF >= 0:
		akt_LP -= dmg - DEF

func levelUp():
	LP += randi() % 5
	ATK += randi() % 3
	DEF += randi() % 3
	EXP = 0