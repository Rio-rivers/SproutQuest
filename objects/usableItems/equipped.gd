#this file can tell when the area2d hits a collision and knows what the current equipped item is
@tool
extends Node2D

@export var currentTool: Equippables:
	set(equipped):
		currentTool = equipped
		

@onready var toolHitBox: Area2D = $Area2D


var toolName: String = "None"#currentTool.itemName#


func getTool() -> String:
	
	return currentTool.itemName


func _on_area_2d_body_entered(body):
	
	if currentTool.has_method("objectInteraction"):
		currentTool.objectInteraction(body)

