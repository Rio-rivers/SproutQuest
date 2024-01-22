extends MarginContainer

@export var itemBarTemplate : PackedScene

@onready var displayGrid: GridContainer = $Grid
var itemsInItemBar: Array[ItemDisplay]
var playerInventory: Inventory

func _ready():

	#find player
	var player: Player = get_tree().get_first_node_in_group("player")
	#finds the class name of player's inventory node
	playerInventory = player.find_child("Inventory") as Inventory
	playerInventory.connect("itemCountUpdate",_on_itemDisplay_changed)


func _on_itemDisplay_changed(item:InventoryItem, numOfItem: int) ->void:
	print("display name: "+ item.displayName + " count: "+ str(numOfItem))
	
	# checks item already exists within itemBar else: create
	var currentItemDisplay: ItemDisplay
	
	for objectDisplay in itemsInItemBar:
		print("TEST")
		#if item already in item bar then update item count 
		if objectDisplay.item == item:
			print("TEST1")
			currentItemDisplay = objectDisplay
			currentItemDisplay.updateItemCount(numOfItem)
			break
		
	# if new item then add new itembar 
	if currentItemDisplay == null:
		print("TEST2")
		var newItemDisplay:ItemDisplay = itemBarTemplate.instantiate() as ItemDisplay
		displayGrid.add_child(newItemDisplay)
		newItemDisplay.item = item
		newItemDisplay.updateItemCount(numOfItem)
		itemsInItemBar.append(newItemDisplay)
	
