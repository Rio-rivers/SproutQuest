extends Area2D
class_name FarmLand

@onready var tilledSoilClass = preload("res://GameSystem/tiles/tilledSoil.tscn")
@onready var children = get_children()
@export var harvestableType: Array[HarvestType]

const MAX_DISTANCE= 16

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setPosition(child, pos):
	child.position = pos
 
func tillLand(toolPosition):
	var localPosition = to_local(toolPosition)
	
	print("tilling",toolPosition)
	for child in get_children():
		if child is TilledSoil:
			var distance = localPosition.distance_to(child.position) 
			if distance < MAX_DISTANCE:
				return
	var tilledSoil = tilledSoilClass.instantiate() as TilledSoil
	tilledSoil.position = localPosition
	tilledSoil.name = "TilledSoil_" + str(randf_range(1,1000))
	print("AREA2D TILLED SOIL POS",tilledSoil.position)
	#add_child(tilledSoil)
	call_deferred("add_child", tilledSoil)
