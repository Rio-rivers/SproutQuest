extends Control

var inventoryOpened: bool = false
@onready var player: Player = get_tree().get_first_node_in_group("players")
@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
@onready var slots: Array= $NinePatchRect/GridContainer.get_children()
var index = 0


func _ready():
	if player:
		playerInventory.connect("itemCountUpdate",updateInventory)
	updateInventory()

func openInventory():
	visible = true
	inventoryOpened = true

	
func closeInventory():
	visible = false
	inventoryOpened = false

func updateInventory() -> void:
	print_inventory(playerInventory)
	print("Inventory Update Started")
	for slot in slots:
		slot.clearSlot()
	index = 0
	for item in playerInventory.items.keys():
		if index < slots.size():
			slots[index].updateSlot(item, playerInventory.items[item])
			index += 1
		else:
			break


#func updateInventory(inventoryItem:Item, numOfItem: int) ->void:
	#print_inventory(playerInventory)
	#print("Inventory Update Started")
	#for slot in slots:
		#var slotItem = slot.getStoredItem()
		#if slotItem == inventoryItem:
			#slot.updateSlot(inventoryItem, numOfItem)
			#break
		#elif slotItem == null:
			#slot.addToSlot(inventoryItem, numOfItem)
			#break

func print_inventory(inventory):
	print("Inventory Contents:")
	for item in inventory.items.keys():
		print("Item: ", item, " Count: ", inventory.items[item])
