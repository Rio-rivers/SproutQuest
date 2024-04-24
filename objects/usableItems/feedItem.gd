extends Equippables

class_name Feed

@export var uses: int = 1
@export var toolType : Array[HarvestType]

const foodTroughLines: Array[String]= ["Hello!","This is a food trough for your animals","Try filling it up with feed from the shop!"]
const waterTroughLines: Array[String]= ["Bonjour!","This is a water trough for your animals","Try filling it up with a watering can!"]
func objectInteraction(body,_toolPosition=null):
	if body is FoodTrough:
		for type in toolType:
			if body.harvestableType.has(type):
				body.fillWithFood(self)
			else:
				TextManager.runDialog(foodTroughLines)
	elif body is WaterTrough:
		TextManager.runDialog(waterTroughLines)
