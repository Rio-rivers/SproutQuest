extends NinePatchRect

@onready var player: Player = get_tree().get_first_node_in_group("players")
@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
@onready var slots:Array = $Panel/container.get_children()
@onready var selectedIcon = $Selected
@onready var timer = $Timer

@export var scrollTimer : float = 0.1

var equip : Equip
var selectedSlot: int = 0
var canScroll: bool = true

func _ready():
	if player:
		equip = player.find_child("EquippedTool")
		for slot in slots:
			slot.equip = equip


func _on_inventory_gui_update_hotbar(slotItems):
	for i in slotItems.keys():
		var hotbar_slot = slots[i]
		var item = slotItems[i]
		if item:
			hotbar_slot.update(item,playerInventory.items[item])
		else:
			hotbar_slot.update(item,0)
		if i == selectedSlot and item and item is Equippables:
			equip.setTool(item)
		if i == selectedSlot and (item == null or not item is Equippables):
			equip.setTool(null)

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		for buttonNumber in range(0, 8):
			var action = "item" + str((buttonNumber+1))
			if Input.is_action_pressed(action):
				selectedSlot = buttonNumber
				moveSelectedIcon(selectedSlot)
				buttonPressed(selectedSlot)
				break
	elif event is InputEventMouseButton and canScroll:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			canScroll = false
			timer.start(scrollTimer)
			selectedSlot = selectedSlot - 1 if selectedSlot > 0 else 7
			moveSelectedIcon(selectedSlot)
			buttonPressed(selectedSlot)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			canScroll = false
			timer.start(scrollTimer)
			selectedSlot = selectedSlot + 1 if selectedSlot < 7 else 0
			moveSelectedIcon(selectedSlot)
			buttonPressed(selectedSlot)
			
func buttonPressed(buttonNumber):
	if buttonNumber <= slots.size():
		selectedSlot = buttonNumber
		var button = slots[buttonNumber]
		button.onPress()
		return
	
	else:
		equip.setTool(null)
	

func moveSelectedIcon(slotIndex):
	selectedIcon.global_position = slots[slotIndex].global_position
	


func _on_timer_timeout():
	canScroll = true
