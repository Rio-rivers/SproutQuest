extends MarginContainer

#sends a signal when an item has been equipped
signal itemEquipped(item)


@export var itemBarTemplate : PackedScene

@onready var displayGrid: GridContainer = $Grid
#find player
@onready var player: Player = get_tree().get_first_node_in_group("players")
var itemsInItemBar: Array[ItemDisplay]
var equip : Equip
var playerInventory: Inventory

func _ready():
	if player:
		#finds the class name of player's inventory node
		playerInventory = player.find_child("Inventory") as Inventory
		playerInventory.connect("itemCountUpdate",_on_itemDisplay_changed)
		equip = player.find_child("EquippedTool")
		
		#checks the itembar for usable items
		for button in displayGrid.get_children():
			if button is itemBarButton:
				print('BUTTON IS ITEMBARBUTTON')
				button.equip = equip
				button.connect("buttonPressed",onEquipItem)
	
	
func onEquipItem(item):
	emit_signal("itemEquipped", item)

func _on_itemDisplay_changed(item:InventoryItem, numOfItem: int) ->void:
	print("display name: "+ item.displayName + " count: "+ str(numOfItem))
	
	# checks item already exists within itemBar else: create
	var currentItemDisplay: ItemDisplay
	
	for objectDisplay in itemsInItemBar:
		#if item already in item bar then update item count 
		if objectDisplay.item == item:
			currentItemDisplay = objectDisplay
			currentItemDisplay.updateItemCount(numOfItem)
			break
		
	# if new item then add new itembar 
	if currentItemDisplay == null:
		var newItemDisplay:ItemDisplay = itemBarTemplate.instantiate() as ItemDisplay
		displayGrid.add_child(newItemDisplay)
		newItemDisplay.item = item
		newItemDisplay.updateItemCount(numOfItem)
		itemsInItemBar.append(newItemDisplay)
	

