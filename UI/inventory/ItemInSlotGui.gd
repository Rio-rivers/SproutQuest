extends Panel

class_name ItemInSlot

@onready var slotItemImage: Sprite2D = $item
@onready var slotItemLabel: Label = $Label

var itemCount = 0
var currentItem: Item = null

func update(item: Item,numOfItem:int):
	currentItem = item
	itemCount = numOfItem
	slotItemImage.texture= item.itemImage
	slotItemLabel.text = str(numOfItem)
	slotItemLabel.visible = true
	slotItemImage.visible= true

func getItem()->Item:
	return currentItem
	
func delete():
	pass


