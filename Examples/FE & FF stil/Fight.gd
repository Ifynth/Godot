extends Node

signal msg(msg)

var attack_bar
var atk_but
var heal_but
var re_but
var ju_but

var tp
var te
var attack_allowed
var dmg
var game_over
var firstatk
var potion_count
var juking

var player_Health
var enemy_Health

var one_time_msg = false
var one_time2 = false

func _ready():
	game_over = false
	attack_allowed = false
	firstatk = false
	player_Health = 120
	enemy_Health = 200
	potion_count = 2
	juking = false
	dmg = 0
	get_node("Control/Potion Count").set_text(String(potion_count) + "x Potion")
	#get_node("Control/Bar/AttackBarEnemy").set_opacity(0)
	
	connect("msg", get_node("Control/Fight Text"), "_on_Fight_msg")
	attack_bar = get_node("Control/Bar/AttackBar")
	atk_but = get_node("Control/Attack Button")
	heal_but = get_node("Control/Heal Button")
	re_but = get_node("Control/Restart")
	ju_but = get_node("Control/Juke Button")
	atk_but.set_disabled(true)
	heal_but.set_disabled(true)
	re_but.set_disabled(true)
	ju_but.set_disabled(true)
	re_but.set_opacity(0)
	
	tp = get_node("Timer")
	tp.set_one_shot(true)
	tp.start()
	
	te = get_node("EvilTimer")
	te.set_one_shot(true)
	
	emit_signal("msg", "Der Kampf wird gestartet!")
	randomize()
	if (randi() % 6 == 0):
		emit_signal("msg", "Der Feind hat dich noch nicht entdeckt!")
		firstatk = true
	else:
		te.start()
	
	
	set_process_input(true)
	set_process(true)

func _input(event):
	
	# ATTACK BUTTON PRESSED
	if atk_but.is_pressed() and attack_allowed and not game_over:
		print("Player ATK")
		if (randi() % 30 == 0):
			dmg = (randi() % 40) * 3
			emit_signal("msg", "Critical HIT!!!")
		elif(randi() % 20 == 0):
			dmg = 0
			emit_signal("msg", "OMG, the enemy dodged your attack :O")
		else:
			dmg = randi() % 40
			if dmg > 30:
				emit_signal("msg", "You hit his Weakspot! Great! Keep it up!")
			elif dmg < 15:
				emit_signal("msg", "Try to Hit enemy's weakspot!")
			elif dmg == 0:
				emit_signal("msg", "Wow that was a fast reaction from the enemy, he dodged")
			else:
				emit_signal("msg", "Clean HIT!")
			emit_signal("msg", "You dealt " + String(dmg) + " Damage")
		enemy_Health -= dmg
		if enemy_Health < 100 and !one_time_msg:
			emit_signal("msg", "You can do it! You are half way through")
			one_time_msg = true
		if enemy_Health < 30:
			emit_signal("msg", "Fast! finish him!!")
		if enemy_Health < 0:
			emit_signal("msg", "You made it OMG!!!! Well Played, you won!!")
			game_over=true
		
		if firstatk:
			te.start()
			firstatk = false
		
		tp.start()
	
	# HEAL BUTTON PRESSED
	if heal_but.is_pressed() and player_Health != 120 and attack_allowed and not game_over:
		tp.set_wait_time(3)
		tp.start()
		
		if potion_count != 0:
			player_Health += 42
			if player_Health > 120:
				player_Health = 120
			potion_count -= 1
			get_node("Control/Potion Count").set_text(String(potion_count) + " Potions")
		else:
			emit_signal("msg", "You are out of Potions!!")
	
	# JUKE BUTTOn PRESSED
	if ju_but.is_pressed() and attack_allowed and not game_over:
		tp.set_wait_time(10)
		tp.start()
		juking = true
		one_time2 = true
	
	# RESTART BUTTON PRESSED
	if re_but.is_pressed():
		get_tree().change_scene("res://Fight.tscn")

func _process(delta):
	if game_over:
		re_but.set_disabled(false)
		re_but.set_opacity(1)
	
	if tp.get_time_left() != 0:
		attack_bar.set_value((tp.get_wait_time()-tp.get_time_left())*100 / tp.get_wait_time())
		atk_but.set_disabled(true)
		heal_but.set_disabled(true)
		ju_but.set_disabled(true)
	else:
		attack_allowed = true
		tp.set_wait_time(5)
		atk_but.set_disabled(false)
		heal_but.set_disabled(false)
		ju_but.set_disabled(false)
	
	if tp.get_time_left() < 4:
		if one_time2:
			emit_signal("msg", "You got Exhausted from juking...")
		one_time2 = false
		juking = false
	
	if te.get_time_left() == 0 and not firstatk and not game_over:
		print("Enemy ATK")
		if randi() % 20 == 0 or juking:
			emit_signal("msg", "Great work, you juked the enemy's attack!")
			te.set_wait_time(6)
		elif te.get_wait_time() == 9:
			emit_signal("msg", "The Enemy is going to attack right now!!")
			player_Health -= randi() % 40 * 6
			te.set_wait_time(5)
		elif randi() % 100 == 0:
			emit_signal("msg", "That's not good. The Enemy hit your Weakspot")
			player_Health -= randi() % 40 * 4
			te.set_wait_time(3)
		elif randi() % 10 == 0:
			emit_signal("msg", "Oh no, the enemy charges his next attack, be prepared")
			te.set_wait_time(9)
		else:
			var i = randi() % 4
			if i == 0:
				emit_signal("msg", "The Enemy hit you with his tail")
			elif i == 1:
				emit_signal("msg", "Ouch, that headbutt must hurst")
			elif i == 2:
				emit_signal("msg", "The Enemy's Claws hit you")
			else:
				emit_signal("msg", "The enemy got you, be careful!")
			player_Health -= randi() % 50
			te.set_wait_time(4)
		te.start()
		
		if player_Health < 0:
			player_Health = 0
			game_over = true
			emit_signal("msg", "The enemy ripped you into pieces and started to eating your bones....")
	
	get_node("Control/Bar/GoodHealth").set_value(player_Health * 100 / 120)
	get_node("Control/Bar/EvilHealth").set_value(enemy_Health * 100 / 200)
	get_node("Control/Health Wert").set_text(String(player_Health) + " HP")
	get_node("Control/Bar/AttackBarEnemy").set_value((te.get_wait_time()-te.get_time_left()) * 100 / te.get_wait_time())