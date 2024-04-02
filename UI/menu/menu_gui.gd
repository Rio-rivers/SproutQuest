extends Control

var menuOpened: bool = false

signal opened
signal closed

func openMenu():
	visible = true
	menuOpened = true
	opened.emit()
	
func closeMenu():
	visible = false
	menuOpened = false
	closed.emit()
