#this file deals with each slot visually
extends Panel


@onready var backgroundImage: Sprite2D = $background
@onready var itemImage: Sprite2D = $CenterContainer/Panel/item


func updateSlot(item: Item):
	if item:
		itemImage.visible= true
		itemImage.texture= item.itemImage
		backgroundImage.frame = 1
	else:
		itemImage.visible = false
		backgroundImage.frame = 0
		

