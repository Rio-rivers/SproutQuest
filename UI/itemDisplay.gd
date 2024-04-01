# used for non usable items
extends HBoxContainer

class_name ItemDisplay

@onready var textureRect = $TextureRect
@onready var label = $TextureRect/Label

var equip : Equip

var item : InventoryItem:
	set(newItem):
		item = newItem
		textureRect.texture = item.texture

func updateItemCount(numOfItem:int):
	label.text = str(numOfItem)
	

