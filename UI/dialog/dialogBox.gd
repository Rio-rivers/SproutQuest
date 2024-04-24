extends MarginContainer




signal opened(isOpened)

func openDialog(dialogRunning):
	if dialogRunning:
		emit_signal("opened",true)
	else:
		emit_signal("opened",false)
	
