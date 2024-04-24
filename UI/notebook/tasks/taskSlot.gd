extends Panel

@onready var itemImage: Sprite2D = $Panel/Sprite2D
@onready var rewardImage: Sprite2D = $rewardPanel/rewardSprite
@onready var collectLabel: Label = $collectLabel
@onready var descriptionLabel: Label = $descriptionLabel
@onready var progressLabel: Label = $progressLabel
@onready var collectButton: Button = $Button
@onready var color: ColorRect = $ColorRect


var currentTask: Task

var isCompleted: bool = false

signal buttonPressed(Item,Int)

func createSlot(item:Task):
	currentTask = item
	itemImage.texture = item.image
	rewardImage.texture = item.rewardImage
	descriptionLabel.text = item.description
	progressLabel.text = str(0,"/",currentTask.completionCriteria)
	collectLabel.visible = false
	collectButton.disabled = true
	color.visible = false
	
	
func updateSlot(progress:int):
	if progress >= currentTask.completionCriteria:
		collectLabel.visible = true
		collectButton.disabled = false
		color.visible = true
		color.color = "659450b5"
		progressLabel.text = str(currentTask.completionCriteria,"/",currentTask.completionCriteria)
	else:
		progressLabel.text = str(currentTask.taskProgress,"/",currentTask.completionCriteria)

func _on_button_pressed():
	collectButton.disabled = true
	collectLabel.text = "Collected"
	color.color = "a27b68b5"
	currentTask.rewardCollected = true
	emit_signal("buttonPressed",currentTask)
