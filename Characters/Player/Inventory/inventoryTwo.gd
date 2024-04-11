extends Resource

class_name InventoryTwo

var numOfItem:int
@export var items : Dictionary = {Item:numOfItem}

signal itemCountUpdate(item:Item, numOfItem: int)
signal addNewItem(item:Item, numOfItem: int)
signal removedItem


func addItemsToInventory(item: Item, numToAdd):
	
	if item in items:
		items[item] += numToAdd
		emit_signal("itemCountUpdate",item, items[item])
	else:
		items[item] = numToAdd
		emit_signal("addNewItem",item, items[item])
	#emit_signal("itemCountUpdate")

func removeItemsFromInventory(item: Item):
	if item in items:
		items.erase(item)
		emit_signal("removedItem")
		
func depleteItemsFromInventory(item:Item, numToRemove:int):
	if item in items:
		items[item] -= numToRemove
		if items[item] <= 0:
			emit_signal("itemCountUpdate",item, 0)
		else:
			emit_signal("itemCountUpdate",item, items[item])
	
	
