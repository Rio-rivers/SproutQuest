extends HBoxContainer

class_name ItemDisplay

@onready var textureRect = $TextureRect
@onready var label = $TextureRect/Label

var item : InventoryItem:
	set(newItem):
		item = newItem
		textureRect.texture = item.texture

func updateItemCount(numOfItem:int):
	label.text = str(numOfItem)
	
