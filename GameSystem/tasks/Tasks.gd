extends Resource

class_name Task

@export var description:String
@export var image:Texture
@export var taskItemName: String
@export var rewardImage:Texture
@export var type:String 
@export var isCompleted:bool = false
@export var rewardCollected:bool = false
@export var seasonal:bool = false
@export var completionCriteria: int
@export var taskProgress: int = 0
@export var taskItem: Item
@export var reward: Item

signal taskCompleted(task)

func checkCompletion():
	if taskProgress >= completionCriteria:
		isCompleted = true
		emit_signal("taskCompleted", self)
		

func getProgress():
	return taskProgress
	
func renewTask():
	if seasonal:
		isCompleted = false
		rewardCollected = false
		taskProgress = 0

func updateProgress(progress:int, extraInfo = null):
	if taskProgress != completionCriteria:
		if type == "collection":
			taskProgress += progress
	checkCompletion()
