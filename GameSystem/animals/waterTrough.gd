extends StaticBody2D

class_name WaterTrough

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var levelOfWater: int = 0
@export var harvestableType: Array[HarvestType]


var maxLevelOfWater: int = 15

var isEmpty: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newDay",useTrough)

	
func useTrough():
	if !isEmpty:
		levelOfWater -=1
		print("WATER TROUGH USED: ", levelOfWater)
		if levelOfWater == 0:
			isEmpty = true
		updateTrough()

func updateTrough():
	if isEmpty:
		animation.frame = 0
	elif levelOfWater <= 5:
		animation.frame = 1
	elif levelOfWater <= 10:
		animation.frame = 2
	else:
		animation.frame = 3

func fillWithWater():
	if levelOfWater <=10:
		levelOfWater += 5
		isEmpty = false
		updateTrough()
	
func isTroughEmpty()->bool:
	return isEmpty
