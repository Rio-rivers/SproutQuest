extends Node2D

@export var harvestableType: Array[HarvestType]


func _on_gui_closed():
	get_tree().paused = false


func _on_gui_opened():
	get_tree().paused = true

