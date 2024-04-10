#this file is for when seeds are used: this uses the player animation to detect the area body collision
extends Equippables

class_name Seeds

@export var uses: int = 1
@export var itemType : Array[HarvestType]
@export var growableSeason:Array[int]
@export var plantPath: String

var isInSeason:bool = false


func objectInteraction(body,_toolPosition=null):
	IsInSeason()
	if isInSeason:
		if body is TilledSoil:
			var plantInTilledSoil = body.getStoredPlant()
			if !plantInTilledSoil:
				print("area is tilled soil")
				for type in itemType:
					if body.harvestableType.has(type):
						body.insertPlant(self)

func get_plant_scene() -> PackedScene:
	return load(plantPath)

func IsInSeason():
	var currentSeason = TimeManager.getSeason()
	if currentSeason in growableSeason:
		isInSeason = true
	else:
		isInSeason = false
