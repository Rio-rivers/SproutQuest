# This file controls resource items when harvested/hit 

extends StaticBody2D

class_name itemSource

#number of resources it will hold


@export var health : int

#create variable to be able to set the type of resource
@export var resourceType: Array[HarvestType]

var numOfResources = randi_range(1,8)
var currentResources : int


var currentHealth : int :
	set(healthValue):
		if healthValue <= 0:
			queue_free()
			
func _ready():
	currentHealth = health
	currentResources = numOfResources

# CHANGE SO THAT CURRENT RESOURCES WILL GIVE OUT ALL RESOURCES/ SOME RESOURCES BEFORE IT DIES
func harvestResource(damage : int):
	print("before ", currentResources)
	health -= damage
	currentResources -= randi_range(0,currentResources)
	if health <= 0:
			print("health 0" )
			queue_free()
	print("after ", currentResources)
	print(health )
