extends StaticBody2D

class_name FoodTrough

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
#@onready var playerInventory: InventoryTwo 
#@onready var playerInventory = preload("res://Characters/Player/Inventory/playerInventory.tres")

@export var levelOfFood: int = 0
@export var harvestableType: Array[HarvestType]


var maxLevelOfFood: int = 15

var isEmpty: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newDay",useTrough)
	
	
func useTrough():
	if !isEmpty:
		levelOfFood -=1
		print("FooD TROUGH USED: ", levelOfFood)
		if levelOfFood == 0:
			isEmpty = true
		updateTrough()

func updateTrough():
	if isEmpty:
		animation.frame = 0
	elif levelOfFood <= 5:
		animation.frame = 1
	elif levelOfFood <= 10:
		
		animation.frame = 2
	else:
		animation.frame = 3

func fillWithFood(item:Item):
	var playerInventory = load("res://Characters/Player/Inventory/playerInventory.tres")
	if item:
		if levelOfFood <=10:
			levelOfFood += 5
			isEmpty = false
			updateTrough()
			playerInventory.depleteItemsFromInventory(item,1)
	
func isTroughEmpty()->bool:
	return isEmpty
