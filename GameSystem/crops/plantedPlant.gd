extends itemSource

class_name PlantedPlant

@onready var animatedSprite = $AnimatedSprite2D
@onready var area2D = $Area2D
@onready var collision = $CollisionShape2D

@export var plantName:String
@export var age:int
@export var ageUntilHarvest:int
@export var growthStages:int

var frameDuration:int 
var harvestable:bool

func _ready():
	TimeManager.connect("newDay",growth)
	frameDuration = max(ageUntilHarvest / (growthStages - 1), 1)
	
func isHarvestable()->bool:
	print("IS HARVESTABLE>: ", harvestable)
	return harvestable
	
func growth():
	age += 1
	
	if age < ageUntilHarvest:
		var currentFrame = min(age / frameDuration, growthStages - 2)
		animatedSprite.frame = currentFrame
		if animatedSprite.frame == 1:
			collision.disabled = false
	elif age == ageUntilHarvest:
		makeHarvestable()
	print("PLANT AGE: ",age)
	if age == ageUntilHarvest:
		makeHarvestable()
func makeHarvestable():
	print("MADE HARVESTABLE")
	harvestable = true
	animatedSprite.frame = growthStages-1
	
	area2D.monitoring = true
	
