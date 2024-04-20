extends Panel

var isOpened: bool = false

signal toggleNotebook(value)
signal close



func _on_button_pressed():
	if isOpened:
		emit_signal("toggleNotebook",0)
		isOpened = false
	else:
		emit_signal("toggleNotebook",1)
		isOpened = true
