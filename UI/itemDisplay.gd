# used for non usable items
extends HBoxContainer

class_name ItemDisplay

@onready var textureRect = $TextureRect
@onready var label = $TextureRect/Label

var equip : Equip

var item : Item:
	set(newItem):
		item = newItem
		textureRect.texture = item.itemImage

func updateItemCount(numOfItem:int):
	label.text = str(numOfItem)
	

