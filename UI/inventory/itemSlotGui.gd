#this file deals with each slot visually
extends Panel

class_name Slots

@onready var backgroundImage: Sprite2D = $background
@onready var itemImage: Sprite2D = $CenterContainer/Panel/item
@onready var itemLabel: Label = $CenterContainer/Panel/Label
var storedItem: Item = null
var itemCount = 0

func getStoredItem()-> Item:
	return storedItem
	
func is_empty() -> bool:
	return storedItem == null
	
func clearSlot() -> void:
	storedItem = null
	itemCount = 0
	itemImage.visible = false
	backgroundImage.frame = 0
	itemLabel.visible = false
	
func updateSlot(item: Item,numOfItem:int):

	if item:
		storedItem = item
		itemCount = numOfItem
		itemImage.visible= true
		itemImage.texture= item.itemImage
		backgroundImage.frame = 1
		itemLabel.text = str(numOfItem)
		itemLabel.visible = true
		print("UPDATE SLOT: ", item.itemName, itemCount)
	else:
		itemImage.visible = false
		backgroundImage.frame = 0
		
func addToSlot(item: Item,_numOfItem:int):
	print("ADD SLOT")
	if item:
		storedItem = item
		itemImage.visible= true
		itemImage.texture= item.itemImage
		backgroundImage.frame = 1
	else:
		itemImage.visible = false
		backgroundImage.frame = 0
