extends MarginContainer

@export var itemBarTemplate : PackedScene
@export var scrollTimer : float = 0.2
@onready var displayGrid: GridContainer = $Grid
@onready var slots:Array = $Grid.get_children()
@onready var selectedIcon = $Sprite2D
@onready var timer = $Timer
#find player
@onready var player: Player = get_tree().get_first_node_in_group("players")
#@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
var itemsInItemBar: Array[ItemDisplay]
var equip : Equip
#var playerInventory: InventoryTwo
var selectedSlot = 0
var canScroll = true


func _ready():
	if player:
		#finds the class name of player's inventory node
		#playerInventory = player.find_child("Inventory") as Inventory
		
		#playerInventory.connect("itemCountUpdate",_on_itemDisplay_changed)
		equip = player.find_child("EquippedTool")
		
		#checks the itembar for usable items
		for button in displayGrid.get_children():
			if button is itemBarButton:
				button.equip = equip

func _unhandled_input(event):
	# runs when a keyboard input is used
	if event is InputEventKey and event.pressed:
		for buttonNumber in range(1, 9):
			var action = "item" + str(buttonNumber)
			if Input.is_action_pressed(action):
				selectedSlot = buttonNumber
				buttonPressed(selectedSlot)
				break
	# else used when a mouse input is used ( allows for scroll wheel input from item 1 to 8 (allows wrap around))
	elif event is InputEventMouseButton and canScroll:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			canScroll = false
			timer.start(scrollTimer)
			selectedSlot = selectedSlot - 1 if selectedSlot > 1 else 8
			
			buttonPressed(selectedSlot)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			canScroll = false
			timer.start(scrollTimer)
			selectedSlot = selectedSlot + 1 if selectedSlot < 8 else 1
			buttonPressed(selectedSlot)
			
func moveSelectedIcon(slotIndex):
	selectedIcon.global_position = slots[slotIndex].global_position
	
func buttonPressed(buttonNumber):
	var children = $Grid.get_children()
	print("item bar button pressed: ", buttonNumber)
	# Ensure the slot index is valid and there is a button in that slot
	if buttonNumber <= children.size():
		selectedSlot = buttonNumber
		
		#checks wwhether selected item is a usable item
		if children[buttonNumber - 1] is itemBarButton:
			var button = children[buttonNumber - 1] as itemBarButton
			button.onPress()
			return
		else:
			equip.setTool(null)
	else:
		equip.setTool(null)
	
		

func _on_itemDisplay_changed(item:Item, numOfItem: int) ->void:
	print("display name: "+ item.itemName + " count: "+ str(numOfItem))
	
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
	



func _on_timer_timeout():
	canScroll = true
