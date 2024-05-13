extends NinePatchRect
@export var shopInventory:ShopInventory
@onready var inventory = shopInventory.shopItems
@onready var purchaseGrid: GridContainer = $purchase
@onready var purchaseButtonLabel: Label = $buyButtonLabel
@onready var purchaseLabel: Label = $purchaseLabel
@onready var sellGrid: GridContainer = $sell
@onready var sellButtonLabel: Label = $sellButtonLabel
@onready var sellLabel: Label = $sellLabel
@onready var purchaseItemSlot = preload("res://GameSystem/shop/itemSlot.tscn")
@onready var sellItemSlot = preload("res://GameSystem/shop/sellItemSlot.tscn")
@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
@onready var player: Player = get_tree().get_first_node_in_group("players")
@onready var gameLevel = $"/root/GameLevel"

signal animalAdded(item,num)

var itemsForSale = []
var itemsForPurchase = []
var marketState = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	var currentSeason = TimeManager.getSeason()
	updateShopInventory(currentSeason)
	player.connect("moneyChanged",updateSlots)
	playerInventory.connect("itemCountUpdate",updateSellableItems)
	playerInventory.connect("addNewItem",updateSellableItems)
	playerInventory.connect("removedItem",updateSellableItems)
	toggleView()
	



func updateShopInventory(season):
	clearChildren()
	itemsForSale.clear()
	itemsForPurchase.clear()
	var itemDict = null
	var isInSeason = null
	var isSellable  = null
	for itemKey in inventory.keys():
		itemDict = inventory[itemKey]
		isInSeason = itemDict.get("seasons", []) and season in itemDict["seasons"]
		isSellable = itemDict.get("sellable", false)
		if isSellable and (not itemDict.has("seasons") or isInSeason):
			itemsForSale.append({"key": itemKey, "price": itemDict["price"]})
		elif not isSellable and isInSeason:
			itemsForPurchase.append({"key": itemKey, "price": itemDict["price"]})
	addItemsToSlots()


func addItemsToSlots():
	var playersMoney = player.getMoney()
	for item in itemsForPurchase:
		var newItemInSlot = purchaseItemSlot.instantiate()
		purchaseGrid.add_child(newItemInSlot)
		newItemInSlot.createSlot(item["key"] as Item, item["price"])
		newItemInSlot.connect("buttonPressed",purchaseItem)
	updateSellableItems()
	updateSlots(playersMoney)
		
func clearChildren():
	for child in purchaseGrid.get_children():
		child.queue_free()
		

func updateSellableItems(_value = null,_number = null):
	var sellSlots = sellGrid.get_children()
	for child in sellSlots:
		sellGrid.remove_child(child)
	for item in itemsForSale:
		if item["key"] in playerInventory.items:
			var newItemInSlot = sellItemSlot.instantiate()
			sellGrid.add_child(newItemInSlot)
			newItemInSlot.createSlot(item["key"] as Item, item["price"])
			newItemInSlot.connect("buttonPressed",sellItem)

func updateSlots(money):
	for slot in purchaseGrid.get_children():
		slot.updateSlot(money)
		
func sellItem(item:Item,cost:int):
	playerInventory.depleteItemsFromInventory(item, 1)
	player.increaseMoney(cost)
	updateSellableItems()


func purchaseItem(item:Item,cost:int):
	if not item is AnimalItem:
		playerInventory.addItemsToInventory(item, 1)
		player.decreaseMoney(cost)
	elif item is AnimalItem:
		if item.animalType == "cow" or item.animalType == "chicken":
			var animal = item.animalInstance.instantiate()
			animal.position = player.position
			gameLevel.add_child(animal)
			call_deferred("emit_signal","animalAdded",0,0)
		player.decreaseMoney(cost)
		


func toggleView():
	if marketState == 0:
		marketState = 1
		purchaseLabel.visible = false
		purchaseButtonLabel.visible = true
		purchaseGrid.visible = false
		sellLabel.visible = true
		sellButtonLabel.visible = false
		sellGrid.visible = true
	else:
		marketState = 0
		sellLabel.visible = false
		sellButtonLabel.visible = true
		sellGrid.visible = false
		purchaseLabel.visible = true
		purchaseButtonLabel.visible = false
		purchaseGrid.visible = true

func _on_shop_toggle_button_pressed():
	toggleView()
