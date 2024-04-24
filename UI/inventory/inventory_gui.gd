extends Control

var inventoryOpened: bool = false
@onready var player: Player = get_tree().get_first_node_in_group("players")
@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
@onready var itemInSlotClass = preload("res://UI/inventory/ItemInSlotGui.tscn")
@onready var slots: Array= $NinePatchRect/GridContainer.get_children()
@onready var bin = $bin
signal updateHotbar(slotItems)
signal opened
signal closed

var index = 0
var selectedSlot: Slots = null
var selectedBin: bool = false


func _ready():
	if player:
		playerInventory.connect("itemCountUpdate",updateSlots)
		playerInventory.connect("addNewItem",addNewItemToSlots)
	fillSlots()
	connectSlots()
	call_deferred("hotbarSlotUpdate")

	

func connectSlots():
	for slot in slots:
		var callable = Callable(_on_slot_clicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
	
func openInventory():
	visible = true
	inventoryOpened = true
	opened.emit()

	
func closeInventory():
	visible = false
	inventoryOpened = false
	closed.emit()


func updateSlots(inventoryItem:Item, numOfItem: int) ->void:
	index = 0
	for slot in slots:
		index += 1
		if not slot.isEmpty() and slot.storedItem.getItem() == inventoryItem:
			if numOfItem == 0:
				binAnItem(slot)
			else:
				slot.storedItem.update(inventoryItem,numOfItem)
			if index < 9:
				hotbarSlotUpdate()
			return
			
func hotbarSlotUpdate():
	var slot = null
	var slotItem
	var slotItems = {}
	for i in range(8):
		slot = slots[i]
		slotItem = (slot.getStoredItem())
		if slotItem:
			slotItem = (slot.storedItem.getItem())
		slotItems[i] = slotItem
	emit_signal("updateHotbar",slotItems)
		
			
func addNewItemToSlots(inventoryItem: Item, numOfItem: int) -> void:
	var newItemInSlot = itemInSlotClass.instantiate() as ItemInSlot
	index = 0
	for slot in slots:
		index += 1
		if slot.isEmpty():
			slot.insertSlot(newItemInSlot)
			newItemInSlot.update(inventoryItem, numOfItem)
			if index < 9:
				hotbarSlotUpdate()
			return

func fillSlots() -> void:
	index = 0
	for item in playerInventory.items.keys():
		if index >= slots.size():
			break
		if slots[index].isEmpty():
			var newItemInSlot = itemInSlotClass.instantiate() as ItemInSlot
			slots[index].insertSlot(newItemInSlot)
			newItemInSlot.update(item, playerInventory.items[item])
			index += 1
		else:
			index += 1
	
	
func moveItemToSlot(currentSlot: Slots, targetSlot:Slots):
	var item = currentSlot.getStoredItem()
	var currentSlotIndex = slots.find(currentSlot)
	var targetSlotIndex = slots.find(targetSlot)
	if item:
		currentSlot.clearSlot(item)
		targetSlot.insertSlot(item)
		if currentSlotIndex < 8 or targetSlotIndex < 8:
			hotbarSlotUpdate()
	selectedSlot = null

	
func _on_slot_clicked(slot):
	if selectedSlot == null:
		if not slot.isEmpty():
			selectedSlot = slot
		return
	if slot.isEmpty():
		moveItemToSlot(selectedSlot, slot)
	elif not slot.isEmpty():
		selectedSlot = slot
	elif slot == selectedSlot:
		selectedSlot = null
	else:
		selectedSlot = null
	


func binAnItem(slot):
	if not slot.isEmpty():
		var itemScene = slot.getStoredItem()
		var item = itemScene.getItem()
		slot.clearSlot(itemScene)
		playerInventory.removeItemsFromInventory(item)

		var slotIndex = slots.find(slot)
		if slotIndex <8:
			hotbarSlotUpdate()


func _on_bin_button_pressed():
	if selectedSlot != null:
		binAnItem(selectedSlot)
		selectedSlot = null
