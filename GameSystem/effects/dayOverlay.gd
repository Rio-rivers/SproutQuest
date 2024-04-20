extends StaticBody2D

@onready var overlay:ColorRect = $ColorRect
# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newTimeOfDay",changeDayOverlay)
	var time = TimeManager.getTimeOfDay()
	changeDayOverlay(time)

func changeDayOverlay(timeOfDay):

	if timeOfDay == 1:
		overlay.visible = false
	elif timeOfDay == 2:
		overlay.visible = true
		overlay.color = "00000e6d"
		overlay.color.a= 0.4
	elif timeOfDay == 3:
		overlay.visible = true
		overlay.color = "00000e9a"
		overlay.color.a = 0.6

