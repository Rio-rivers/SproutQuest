extends Node2D

@onready var player:= $player


var _save: SaveGame

func _ready():
	pass

func _on_gui_closed():
	get_tree().paused = false


func _on_gui_opened():
	get_tree().paused = true

