extends Control

@onready var market: NinePatchRect = $market
@onready var tasks: NinePatchRect = $Tasks

var notebookOpened: bool = false
var currentPage = 1
var totalPages = 0

func _ready():
	TimeManager.connect("newDay",updateGUIDay)
	TimeManager.connect("newSeason",updateGUISeason)
	totalPages = get_child_count() - 2
	updateVisibility()

func openNotebook():
	visible = true
	notebookOpened = true
	tasks.progressTasks(0,0)
	
func closeNotebook():
	visible = false
	notebookOpened = false

func updateGUIDay():
	pass
	
func updateGUISeason(season):
	market.updateShopInventory(season)

func updateVisibility():
	var childIndex = 0 
	for child in get_children():
		if child is NinePatchRect:
			childIndex += 1
			if childIndex == currentPage:
				child.visible = true
			else:
				child.visible = false

			
	
	
func _on_left_button_pressed():
	currentPage = currentPage - 1 if currentPage > 1 else totalPages
	updateVisibility()

func _on_right_button_pressed():
	currentPage = currentPage + 1 if currentPage < totalPages else 1
	updateVisibility()

