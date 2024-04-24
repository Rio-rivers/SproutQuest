extends Area2D
class_name FarmLand

@onready var tilledSoilClass = preload("res://GameSystem/tiles/tilledSoil.tscn")
@onready var children = get_children()
@export var harvestableType: Array[HarvestType]

const MAX_DISTANCE= 16
const farmlandLines: Array[String]= ["Hi!","This is farmland","Try using a hoe to till the soil","you'll then be able to plant seeds on it","once a seed is planted, keep it watered","when the plant grows to harvest ...","harvest with a hoe!"]

func setPosition(child, pos):
	child.position = pos
 
func tillLand(toolPosition):
	var localPosition = to_local(toolPosition)
	
	for child in get_children():
		if child is TilledSoil:
			var distance = localPosition.distance_to(child.position) 
			if distance < MAX_DISTANCE:
				return
	var tilledSoil = tilledSoilClass.instantiate() as TilledSoil
	tilledSoil.position = localPosition
	tilledSoil.name = "TilledSoil_" + str(randf_range(1,1000))
	call_deferred("add_child", tilledSoil)



func _on_body_entered(body):
	if body is Player:
		if !TextManager.farmingTutorial and !TextManager.dialogRunning:
			TextManager.runDialog(farmlandLines)
			TextManager.farmingTutorial = true
