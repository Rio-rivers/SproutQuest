#this file is used for tools which can be used to harvest resources

extends Equippables
class_name Tool
@export var toolDamage: int = 1
@export var toolType : Array[HarvestType]

const lines: Array[String]= ["Howdy!","Im afraid that you cant use that tool here","Try it on something else!"]
const waterTroughLines: Array[String]= ["Bonjour!","This is a water trough for your animals","Try filling it up with a watering can!"]

const foodTroughLines: Array[String]= ["Hello!","This is a food trough for your animals","Try filling it up with feed from the shop!"]
#when a tool interacts with an object: check if it can be harvested
func objectInteraction(body,toolPosition=null):
	#used in 'itemResource' to see if an object is harvestable
	if body is itemSource:
		# for each type that the equipped tool is apart of
		for type in toolType:
			# checks if the resource object is apart of the same type as the tool
			if body.harvestableType.has(type):
				if body is PlantedPlant:
					var harvest = body.isHarvestable()
					if harvest:
						body.harvestResource(toolDamage)
				else:
					body.harvestResource(toolDamage)
			elif type.harvestableTypeName != "Waterable" and !body is FarmLand:
				TextManager.runDialog(lines)
	elif body is TilledSoil:
		for type in toolType:
			if body.harvestableType.has(type):
				body.waterSoil()
			
	elif body is WaterTrough:
		for type in toolType:
			if body.harvestableType.has(type):
				body.fillWithWater()
			else:
				TextManager.runDialog(waterTroughLines)
	elif body is FarmLand:
			for type in toolType:
				if body.harvestableType.has(type):
					body.tillLand(toolPosition)
	elif body is FoodTrough:
		TextManager.runDialog(foodTroughLines)

	
