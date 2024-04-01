extends Control

var inventoryOpened: bool = false

#signal opened
#signal closed

func openInventory():
	visible = true
	inventoryOpened = true
	#opened.emit()
	
func closeInventory():
	visible = false
	inventoryOpened = false
	#closed.emit()
