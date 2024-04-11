#SHOP item slot

extends Panel

@onready var itemImage: Sprite2D = $Panel/Sprite2D
@onready var itemCostLabel: Label = $costLabel
@onready var nameLabel: Label = $nameLabel
@onready var itemButton: Button = $Button
@onready var color: ColorRect = $ColorRect

var currentItem: Item
var itemCost: int
var isPurchasable: bool = false

signal buttonPressed(Item,Int)

func createSlot(item:Item, cost:int):
	currentItem = item
	itemCost = cost
	itemImage.texture = item.itemImage
	nameLabel.text = str(item.itemName)
	itemCostLabel.text = str(itemCost)
	

func updateSlot(money):
	isPurchasable = money >= itemCost
	if !isPurchasable:
		itemButton.disabled = true
		color.color = "a27b68b5"
	else:
		itemButton.disabled = false
		color.color = "659450b5"
func _on_button_pressed():
	emit_signal("buttonPressed",currentItem,itemCost)
