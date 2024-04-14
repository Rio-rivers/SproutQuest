extends Control




func _on_quit_button_pressed():
	get_tree().quit()


func _on_load_button_pressed():
	get_tree().change_scene_to_file("res://Levels/gameLevel.tscn")


func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://Levels/gameLevel.tscn")
