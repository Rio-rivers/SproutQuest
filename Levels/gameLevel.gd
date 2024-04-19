extends Node2D

class_name GameLevel

@onready var player:= $player
@onready var timer: Timer = $Timer


var shouldLoad: bool = false

var time: float = 0.05



func _ready():
	timer.start(time)
	



	

	
func loadlevel():
	print("GAME LEVEL CALLING LOAD")
	SaveLoadGame.load_game()
	SaveLoadGame.createOrLoadInventorySave()

func _on_gui_closed():
	get_tree().paused = false


func _on_gui_opened():
	get_tree().paused = true



func _on_timer_timeout():
	
	SaveLoadGame.controlPanel()
	
