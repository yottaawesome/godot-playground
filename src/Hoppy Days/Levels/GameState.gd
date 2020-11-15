extends Node2D

var lives = 3

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
	get_tree().call_group("GUI", "update_lives", lives)
	

func end_game():
	get_tree().change_scene("res://Levels/EndGame.tscn")
