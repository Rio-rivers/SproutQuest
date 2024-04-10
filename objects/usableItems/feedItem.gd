extends Equippables

class_name Feed

@export var uses: int = 1
@export var toolType : Array[HarvestType]

func objectInteraction(body,_toolPosition=null):
	if body is FoodTrough:
		for type in toolType:
			if body.harvestableType.has(type):
				body.fillWithFood(self)
