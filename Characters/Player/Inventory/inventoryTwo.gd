extends Resource

class_name InventoryTwo

var numOfItem:int
@export var items : Dictionary = {Item:numOfItem}

signal itemCountUpdate(item:Item, numOfItem: int)
signal addNewItem(item:Item, numOfItem: int)


func addItemsToInventory(item: Item, numOfItem):
	
	if item in items:
		items[item] += numOfItem
		emit_signal("itemCountUpdate",item, items[item])
	else:
		items[item] = numOfItem
		emit_signal("addNewItem",item, items[item])
	#emit_signal("itemCountUpdate")
	
	
