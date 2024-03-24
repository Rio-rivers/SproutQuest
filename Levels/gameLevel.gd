extends Node2D

@onready var playerNode = $player/EquippedTool
@onready var itemNode = $CanvasLayer/itemBar
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

	#itemNode.connect("itemEquipped", playerNode, "setTool")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

