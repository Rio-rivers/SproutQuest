#this file deals with each slot visually
extends Button

class_name Slots

@onready var backgroundImage: Sprite2D = $background
@onready var itemContainer: CenterContainer = $CenterContainer

var storedItem: ItemInSlot = null

func getStoredItem()-> ItemInSlot:
	return storedItem
	
func isEmpty() -> bool:
	return storedItem == null
	
func clearSlot(item:ItemInSlot) -> void:
	if storedItem:
		itemContainer.remove_child(item)
	storedItem = null
	backgroundImage.frame = 0
	
func insertSlot(item:ItemInSlot):
	if item:
		storedItem = item
		backgroundImage.frame = 1
		itemContainer.add_child(item)
	else: 
		backgroundImage.frame = 0
		
