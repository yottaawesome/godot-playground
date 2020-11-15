extends CanvasLayer

func _ready():
	pass


func update_lives(lives_left):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
