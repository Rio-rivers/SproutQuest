extends StaticBody2D

class_name WaterTrough

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var levelOfContents: int = 0
@export var harvestableType: Array[HarvestType]


var maxLevelOfWater: int = 15

var isEmpty: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newDay",useTrough)

	
func useTrough():
	if !isEmpty:
		levelOfContents -=1
		if levelOfContents == 0:
			isEmpty = true
		updateTrough()

func updateTrough():
	if isEmpty:
		animation.frame = 0
	elif levelOfContents <= 5:
		animation.frame = 1
	elif levelOfContents <= 10:
		animation.frame = 2
	else:
		animation.frame = 3

func save():
	
	var saveDict = {
		"levelOfContents": levelOfContents,
		"isEmpty": isEmpty,
		"type": "WaterTrough"
	}
	return saveDict

func fillWithWater():
	if levelOfContents <=10:
		levelOfContents += 5
		isEmpty = false
		updateTrough()
	
func isTroughEmpty()->bool:
	return isEmpty
