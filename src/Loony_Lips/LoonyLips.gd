extends Control

var player_words = []
var template = [
	{
		"prompts": ["a name", "a noun", "an adverb", "adjective"],
		"story": "Once upon a time, %s played %s and it made him all %s inside. It was a %s day."
	},
	{
		"prompts": ["a name", "a noun", "an adjective"],
		"story": "Here is %s, he is a %s who is %s."
	}
]
var current_story = null	

onready var player_text = $VBoxContainer/HBoxContainer/PlayerText
onready var button_label = $VBoxContainer/HBoxContainer/ButtonLabel
onready var display_text = $VBoxContainer/DisplayText

func _ready():
	set_current_story()
	display_text.text = "Welcome to LoonyLips! "
	check_player_word_length()
	player_text.grab_focus()

func set_current_story():
	randomize()
	current_story = template[randi() % template.size()]


func _on_PlayerText_text_entered(_new_text):
	add_to_player_words()


func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()


func add_to_player_words():
	player_words.append(player_text.text)
	player_text.clear()
	display_text.text = ''
	check_player_word_length()


func is_story_done():
	return player_words.size() == current_story.prompts.size()


func check_player_word_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()


func tell_story():
	display_text.text = current_story.story % player_words


func prompt_player():
	display_text.text += "May I have " + current_story.prompts[player_words.size()] + " please?"


func end_game():
	player_text.queue_free()
	tell_story()
	button_label.text = "Again!"
