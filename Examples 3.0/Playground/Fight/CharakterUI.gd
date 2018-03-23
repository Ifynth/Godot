extends Control

func createHealthbar(hp):
	$Healthbar.createPoints(hp)

func takeDamage(hp):
	$Healthbar.takeDmg(hp)