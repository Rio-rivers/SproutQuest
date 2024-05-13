extends Control

@onready var musicToggle: TextureButton = $NinePatchRect/MarginContainer/VBoxContainer/musicToggle/musicToogleButton

var menuOpened: bool = false
var musicOn: bool = true

signal opened
signal closed

func _ready():
	musicToggle.toggle_mode = true
	if Music.playing:
		musicToggle.pressed
	else:
		musicToggle.button_pressed = false

func openMenu():
	visible = true
	menuOpened = true
	opened.emit()
	
func closeMenu():
	visible = false
	menuOpened = false
	closed.emit()


func _on_save_button_pressed():
	SaveLoadGame.saveGame()
	SaveLoadGame.saveToInventorySave()


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://GameSystem/mainMenu/mainMenu.tscn")




func _on_close_button_pressed():
	closeMenu()


func _on_music_toogle_button_toggled(toggled_on):
	print("TOGGLED ON")
	if musicOn:
		Music.stop()
		musicOn = false
	else:
		Music.play()
		musicOn = true
