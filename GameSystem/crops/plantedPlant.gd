extends itemSource

class_name PlantedPlant

@onready var animatedSprite = $AnimatedSprite2D
@onready var area2D = $Area2D

@export var plantName:String
@export var age:int
@export var ageUntilHarvest:int
@export var growthStages:int

var frameDuration:int 
var harvestable:bool

func _ready():
	TimeManager.connect("newDay",growth)
	frameDuration = ageUntilHarvest / growthStages
	
func isHarvestable()->bool:
	print("IS HARVESTABLE>: ", harvestable)
	return harvestable
	
func growth():
	age += 1
	print(age)
	var currentFrame = min(age / frameDuration, growthStages)-1
	print("CURRENT FRAME: ",currentFrame)
	animatedSprite.frame = currentFrame
	
	if age == ageUntilHarvest:
		makeHarvestable()

func makeHarvestable():
	print("MADE HARVESTABLE")
	harvestable = true
	area2D.monitoring = true
	
