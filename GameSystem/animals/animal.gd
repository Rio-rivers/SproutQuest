extends CharacterBody2D

class_name Animal
@onready var gameLevel = get_parent()
@onready var gameItems = gameLevel.find_child("worldObjects")
@onready var waterTrough: StaticBody2D = gameItems.find_child("waterTrough")
@onready var foodTrough: StaticBody2D = gameItems.find_child("foodTrough")

@export var age: int = 1
@export var happiness: float = 50.0
@export var fed: bool = false
@export var watered: bool = false
@export var ageOfMaturity: int
@export var isMature: bool = false
@export var maxAge: int
@export var produce: PackedScene

var timeSinceWatered: int
var timeSinceFed:int


func _exit_tree():
	SeasonSummary.animalsLeft += 1
	
func growAnimal():
	age += 1
	if !fed:
		updateHappiness(0,6.0)
	if !watered:
		updateHappiness(0,10.0)
	fed = false
	watered = false
	if age == ageOfMaturity:
		matureAnimal()
	elif age > maxAge:
		print("animal left because of age")
		leaveFarm()
	if isMature and happiness > 30.0:
		giveProduce()

func matureAnimal():
	isMature = true
	

func giveProduce():
	var lootItem: Loot = produce.instantiate() as Loot
	gameLevel.call_deferred("add_child", lootItem)
	lootItem.position = position
	lootItem.bounce()

func getFood():
	var checkFoodTroughisEmpty = foodTrough.isTroughEmpty()
	if !checkFoodTroughisEmpty:
		foodTrough.useTrough()
		fed = true
		updateHappiness(1,3.0)
		return true
	else:
		return false
		
	
func getWater():
	var checkWaterTroughisEmpty = waterTrough.isTroughEmpty()
	if !checkWaterTroughisEmpty:
		waterTrough.useTrough()
		watered = true
		updateHappiness(1,5.0)
		return true
	else:
		return false
	
func updateHappiness(method,value):
	if method == 0:
		happiness -= value
	else:
		happiness += value
	if happiness <= 10.0:
		print("animal left because of unhappiness")
		leaveFarm()
	
func leaveFarm():
	call_deferred("queue_free")
