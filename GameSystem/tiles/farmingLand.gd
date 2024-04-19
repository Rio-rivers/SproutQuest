extends Area2D
class_name FarmLand

@onready var tilledSoilClass = preload("res://GameSystem/tiles/tilledSoil.tscn")
@onready var children = get_children()
@export var harvestableType: Array[HarvestType]

const MAX_DISTANCE= 16

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func save():
	var children = []
	for child in get_children():
		if child.has_method("save") :
			children += child
	var saveDict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"harvestType": harvestableType,
		"children": children,
	}
	return saveDict

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
	#add_child(tilledSoil)
	call_deferred("add_child", tilledSoil)
