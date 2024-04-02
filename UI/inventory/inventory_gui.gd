extends Control

var inventoryOpened: bool = false

@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
@onready var slots: Array= $NinePatchRect/GridContainer.get_children()

func _ready():
	updateInventory()

func openInventory():
	visible = true
	inventoryOpened = true

	
func closeInventory():
	visible = false
	inventoryOpened = false

func updateInventory():
	for slot in range (min(playerInventory.items.size(),slots.size())):
		slots[slot].updateSlot(playerInventory.items[slot])
