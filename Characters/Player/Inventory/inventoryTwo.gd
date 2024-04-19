extends Resource

class_name InventoryTwo

var numOfItem:int
@export var items : Dictionary = {Item:numOfItem}

signal itemCountUpdate(item:Item, numOfItem: int)
signal addNewItem(item:Item, numOfItem: int)
signal removedItem

func _init():
	items = {}
func getInventory():
	var tempDir = {}
	for item in items:
		var itemPath = item.scene_file_path
		tempDir[itemPath] = items[item]
	return tempDir

func loadInventory(data):
	var itemsToRemove = items.keys()
	for item in itemsToRemove:
		depleteItemsFromInventory(item,items[item])
	items.clear()
	
	for item in data.keys():
		addItemsToInventory(item, data[item])
		

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
	
	
