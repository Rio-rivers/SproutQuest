# This file controls resource items when harvested/hit 

extends StaticBody2D

class_name itemSource

@export var health : int

#create variable to be able to set the type of resource
@export var harvestableType: Array[HarvestType]
@export var lootTypes: Array[PackedScene]

@onready var gameLevel = get_parent()

var numOfResources : int


func harvestResource(damage : int):
	
	numOfResources = randomResourceCount()
	
	for item in range(numOfResources):
		spawnLoot(0)
		
	health -= damage
	if health <= 0:
		for item in range(numOfResources):
			spawnLoot((lootTypes.size()-1))
		call_deferred("queue_free")
	
	
func randomResourceCount() -> int:
	var roll = randf()
	if roll < 0.7:
			return 1
	elif roll < 0.9: 
		return 2
	else:
		return 3
func spawnLoot(lootIndex: int):
	var lootItem: Loot = lootTypes[lootIndex].instantiate() as Loot
	gameLevel.call_deferred("add_child", lootItem)
	lootItem.position = position
	
	lootItem.bounce()
