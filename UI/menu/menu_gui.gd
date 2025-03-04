extends Control

@onready var settings:Node = $settingsGUI

var menuOpened: bool = false

signal opened
signal closed

func _ready():
	settings.closeMenu()
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


func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_button_pressed():
	settings.openMenu()

