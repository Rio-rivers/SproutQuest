extends CanvasLayer

@onready var inventoryGui = $InventoryGui
@onready var menuGui = $MenuGui

func _ready():
	inventoryGui.closeInventory()
	menuGui.closeMenu()
	
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
