extends Area2D


func _on_SpikeTop_body_entered(body):
	#if body.has_method("hurt"): # error check
	#	body.hurt()
	get_tree().call_group("Gamestate", "hurt")
