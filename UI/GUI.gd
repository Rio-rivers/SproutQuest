extends CanvasLayer

@onready var inventoryGui = $InventoryGui
@onready var menuGui = $MenuGui
@onready var notebookGui = $notebookGUI
@onready var notebookSignal = $notebookIcon

signal open
signal close

func _ready():
	inventoryGui.closeInventory()
	menuGui.closeMenu()
	notebookGui.closeNotebook()
	notebookSignal.connect("toggleNotebook",toggleNotebook)


func toggleNotebook(value):
	if value == 0:
		notebookGui.closeNotebook()
		emit_signal("close")
	else:
		notebookGui.openNotebook()
		emit_signal("open")
	
func _input(event):
	if event.is_action_pressed("inventoryToggle"):
		if inventoryGui.inventoryOpened:
			inventoryGui.closeInventory()
		else:
			inventoryGui.openInventory()
	elif event.is_action_pressed("menuToggle"):
		if menuGui.menuOpened:
			menuGui.closeMenu()
		else:
				menuGui.openMenu()
	elif event.is_action_pressed("notebookToggle"):
		if notebookGui.notebookOpened:
			notebookGui.closeNotebook()
			emit_signal("close")
		else:
				notebookGui.openNotebook()
				emit_signal("open")
				

