extends Control

#@onready var gameLevel = preload("res://Levels/gameLevel.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func changeScene(shouldLoad: bool):
	var gameLevel = preload("res://Levels/GameLevel.tscn").instantiate()
	#get_tree().root.add_child(gameLevel)
	#var test = get_tree().root.get_child(3)
	#get_tree().set_current_scene (test)
	
	get_tree().change_scene_to_packed(gameLevel)
	gameLevel.shouldLoad = shouldLoad



func _on_load_button_pressed():
	#changeScene(true)
	get_tree().change_scene_to_file("res://Levels/gameLevel.tscn")
	SaveLoadGame.loadOldWorld = true
	


func _on_new_game_button_pressed():
	#changeScene(false)
	get_tree().change_scene_to_file("res://Levels/gameLevel.tscn")
	SaveLoadGame.loadOldWorld = false

