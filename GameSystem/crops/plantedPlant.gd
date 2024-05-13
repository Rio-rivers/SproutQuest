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
	add_to_group("saveable")


func getTilledParent():
	var parent = self.get_parent()
	var tilled = parent.get_parent()
	if tilled:
		return tilled

func isHarvestable()->bool:
	return harvestable
	
func save():
	var saveDict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"harvestType": harvestableType,
		"age": age,
		"harvestable": harvestable,
	}
	return saveDict
	
func growth():
	age += 1
	checkAge()
	
func checkAge():
	if age < ageUntilHarvest:
		var currentFrame = min(age / frameDuration, growthStages - 2)
		animatedSprite.frame = currentFrame
	elif age >= ageUntilHarvest:
		makeHarvestable()
	if animatedSprite.frame >= 1 and collision.disabled:
		collision.disabled = false
	

func makeHarvestable():
	harvestable = true
	animatedSprite.frame = growthStages-1
	
	area2D.monitoring = true
	
