#this file is used for tools which can be used to harvest resources

extends Equippables

class_name Tool

@export var toolDamage: int = 1
@export var toolType : Array[HarvestType]


#when a tool interacts with an object: check if it can be harvested
func objectInteraction(body):
	#used in 'itemResource' to see if an object is harvestable
	if body is itemSource:
		# for each type that the tool is apart of
		for type in toolType:
			#if the resource object is apart of the same type as the tool do something
			if body.harvestableType.has(type):

				body.harvestResource(toolDamage)
			
