extends NinePatchRect

@onready var grid: GridContainer = $GridContainer
@onready var taskSlot = preload("res://UI/notebook/tasks/taskSlot.tscn")
@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")

@export var tasks: Array[Task]

# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newDay",updateTasks)
	TimeManager.connect("newSeason",updateTasks)
	playerInventory.connect("itemCountUpdate",progressTasks)
	playerInventory.connect("addNewItem",progressTasks)
	displayTasks()
	
func displayTasks():
	var slots = grid.get_children()
	for child in slots:
		if !child.currentTask.isCompleted or child.currentTask.rewardCollected:
			grid.remove_child(child)
	for task in tasks:
		if !task.isCompleted : #or !task.rewardCollected
			var newTaskSlot = taskSlot.instantiate()
			grid.add_child(newTaskSlot)
			newTaskSlot.createSlot(task)
			newTaskSlot.connect("buttonPressed",giveRewards)

func clearChildren():
	for child in grid.get_children():
		call_deferred("queue_free",child)
		
func updateOnceTasks():
	for task in tasks:
		if task.rewardCollected and !task.seasonal:
			task.renewTask()
		elif !task.isCompleted:
			progressTasks()
	displayTasks()
		
func updateTasks(_season=null):
	for task in tasks:
		if task.rewardCollected and task.seasonal:
			task.renewTask()
		elif !task.isCompleted:
			progressTasks()
	displayTasks()

func progressTasks(item:Item = null, countOfItem = null):
	for task in tasks:
		if !task.isCompleted:
			if task.type == "collection":
				if item:
					if task.taskItemName == item.itemName:
						task.updateProgress(countOfItem)
						for slot in grid.get_children():
							print("SLOT")
							if slot.currentTask == task:
								slot.updateSlot(task.taskProgress)

func giveRewards(task):
	print("GIVE REWARD")
	var rewardItem = task.reward as Item
	playerInventory.addItemsToInventory(rewardItem, 1)

