extends Node2D


var lives = 3
var coins = 0
export var target_number_of_coins = 10


func _ready():
	add_to_group("Gamestate")
	update_GUI()


func hurt():
	lives -= 1
	$Player.hurt()
	if lives < 0:
		end_game()
	update_GUI()


func update_GUI():
	get_tree().call_group("GUI", "update_gui", lives, coins)


func coin_up():
	coins += 1
	get_tree().call_group("GUI", "update_gui", lives, coins)
	var multiple_of_coins = (coins % target_number_of_coins) == 0
	if multiple_of_coins:
		life_up()


func life_up():
	lives += 1
	update_GUI()


func end_game():
	get_tree().change_scene("res://Levels/EndGame.tscn")
