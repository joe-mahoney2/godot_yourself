extends CanvasLayer


func _on_button_pressed():
	# restart the game
	get_tree().reload_current_scene()
