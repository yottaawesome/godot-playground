extends Control

func _ready():
	var prompts = ["Vasilios", "Goldeneye 64", "the greatest game ever made", "amazing"]
	var story = "Once upon a time, %s played %s and thought it was %s. To this day, he still thinks it's %s."
	print(story % prompts)
	
	prompts[1] = "Perfect Dark"
	prompts[2] = "an awesome successor to GoldenEye 64"
	prompts[3] = "pretty damn good"
	print(story % prompts)
	
	# Can also use $Label instead of get_node("Label")
	get_node("DisplayText").text = story % prompts
