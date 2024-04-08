@tool

extends Button

class_name HotbarSlots

@onready var backgroundImage: Sprite2D = $background
@onready var itemInSlot: ItemInHotbarSlot = $CenterContainer/hotbarSlotItem

var storedItem: Item = null
var equip : Equip

func onPress():
	if storedItem is Equippables:
		if equip != null:
			equip.setTool(storedItem)
	else:
		equip.setTool(null)
	
func update(item:Item, numOfItem):
	if item:
		itemInSlot.update(item, numOfItem)
		backgroundImage.frame = 1
		storedItem = item
		itemInSlot.visible = true
		
	else: 
		backgroundImage.frame = 0
		itemInSlot.visible = false
		storedItem = null
	
