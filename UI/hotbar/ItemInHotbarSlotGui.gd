extends Panel

class_name ItemInHotbarSlot

@onready var slotItemImage: Sprite2D = $item
@onready var slotItemLabel: Label = $Label

var itemCount = 0
var currentItem: Item = null

func update(item: Item,numOfItem:int):
	currentItem = item
	itemCount = numOfItem
	slotItemImage.texture= item.itemImage
	slotItemLabel.text = str(numOfItem)
	slotItemImage.visible= true
	if item is Tool:
		slotItemLabel.visible = false
	else:
		slotItemLabel.visible = true
