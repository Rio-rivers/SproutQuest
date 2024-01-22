extends Node

class_name Inventory

@export var items : Dictionary = {}

signal itemCountUpdate(item:InventoryItem, numOfItem: int)


func addItemsToInventory(item: InventoryItem, numOfItem: int):
	if item in items:
		items[item] += numOfItem
	else:
		items[item] = numOfItem
		
	emit_signal("itemCountUpdate",item, items[item])
