extends Control

@onready var market: NinePatchRect = $market

var notebookOpened: bool = false


func _ready():
	TimeManager.connect("newDay",updateGUIDay)
	TimeManager.connect("newSeason",updateGUISeason)

func openNotebook():
	visible = true
	notebookOpened = true


func closeNotebook():
	visible = false
	notebookOpened = false

func updateGUIDay():
	pass
	
func updateGUISeason(season):
	market.updateShopInventory(season)
