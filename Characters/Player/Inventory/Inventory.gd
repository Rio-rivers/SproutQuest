extends Node

class_name Inventory

@export var items : Dictionary = {}

signal itemCountUpdate(item:Item, numOfItem: int)


func addItemsToInventory(item: Item, numOfItem: int):
	if item in items:
		items[item] += numOfItem
	else:
		items[item] = numOfItem
		
	emit_signal("itemCountUpdate",item, items[item])
