#this file can tell when the area2d hits a collision and knows what the current equipped item is
@tool
extends Node2D
class_name Equip
signal equippedItem(item)

@export var currentTool: Equippables:
	set(equipped):
		currentTool = equipped
		

@onready var toolHitBox: Area2D = $Area2D


var toolName: String = "None"

func setTool(tool):
	if tool == null:
		currentTool = null
		toolName = "None"
	else:
		currentTool = tool
		toolName = currentTool.itemName
	print("SET TOOL: ", toolName)
	equippedItem.emit(toolName)
	

func getTool() -> String:
	if currentTool != null:
		return currentTool.itemName
	else:
		return toolName


func _on_area_2d_body_entered(body):
	
	if currentTool.has_method("objectInteraction"):
		currentTool.objectInteraction(body)

