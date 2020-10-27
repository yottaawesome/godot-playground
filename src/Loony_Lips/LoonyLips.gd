extends Control

var player_words = []
var current_story = {}	

onready var player_text = $VBoxContainer/HBoxContainer/PlayerText
onready var button_label = $VBoxContainer/HBoxContainer/ButtonLabel
onready var display_text = $VBoxContainer/DisplayText

func _ready():
	set_current_story()
	display_text.text = "Welcome to LoonyLips! "
	check_player_word_length()
	player_text.grab_focus()

func set_current_story():
	var stories = get_from_json("storybook.json")
	randomize()
	current_story = stories[randi() % stories.size()]
	
	# using StoryBook nodes
	#var stories = $StoryBook.get_child_count()
	#var selected_story = randi() % stories
	#current_story.prompts = $StoryBook.get_child(selected_story).prompts
	#current_story.story = $StoryBook.get_child(selected_story).story


func get_from_json(file_name):
	var file = File.new()
	file.open(file_name, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data


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
