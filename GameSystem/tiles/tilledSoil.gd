extends Area2D

class_name TilledSoil

@export var harvestableType: Array[HarvestType]

@onready var backgroundImage: Sprite2D = $background
@onready var plantContainer: CenterContainer = $CenterContainer


const TIME_UNTIL_UNTILLED: int = 4
const MAX_UNWATERED_TIME: int = 3

var plantGrowing: PlantedPlant = null
var watered: bool = false
var tilled: bool = true
var daysSinceWater: int = 0

func _ready():
	TimeManager.connect("newDay",newDay)
	add_to_group("saveable")

	
func save():

	var saveDict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"harvestType": harvestableType,
		"name": name,
		"watered":watered,
		"posX": position.x,
		"posY": position.y,
	}
	return saveDict
	
func newDay():
	if plantGrowing:
		if !watered:
			daysSinceWater+=1
			if daysSinceWater >= MAX_UNWATERED_TIME:
				SeasonSummary.cropsDied += 1
				clearPlant()
	elif !plantGrowing:
		if !watered:
			daysSinceWater+=1
			if daysSinceWater >=TIME_UNTIL_UNTILLED:
				queue_free()
	backgroundImage.frame = 1
	watered = false

func getStoredPlant()-> PlantedPlant:
	return plantGrowing
	
func isEmpty() -> bool:
	return plantGrowing == null
	
func clearPlant() -> void:
	if plantGrowing:
		plantContainer.remove_child(plantGrowing)
	plantGrowing = null
	
func insertPlant(item:Item):
	
	if item and item is Seeds:
		var seeds = item as Seeds
		var plantScene = seeds.get_plant_scene()
		if plantScene:
			daysSinceWater = 0
			var plantInstance = plantScene.instantiate() as PlantedPlant
			var playerInventory = load("res://Characters/Player/Inventory/playerInventory.tres")
			SeasonSummary.cropsPlanted += 1
			plantContainer.call_deferred("add_child", plantInstance)
			plantGrowing = plantInstance
			playerInventory.depleteItemsFromInventory(item,1)

func waterSoil():
	backgroundImage.frame = 0
	watered = true

