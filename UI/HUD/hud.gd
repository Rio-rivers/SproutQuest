extends NinePatchRect

@onready var dayText: Label = $day/dayLabel
@onready var seasonIcon: AnimatedSprite2D = $day/AnimatedSprite2D
@onready var moneyText: Label = $money/Label
@onready var player: Player = get_tree().get_first_node_in_group("players")

var day = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newSeason",updateSeason)
	TimeManager.connect("newDay",updateDay)
	player.connect("moneyChanged", updateMoney)
	

func updateDay():
	day = TimeManager.getDay()
	dayText.text = str(day)
	
func updateSeason(season):

	if season == 1:
		seasonIcon.frame = 0
	elif season == 2:
		seasonIcon.frame = 1
	elif season == 3:
		seasonIcon.frame = 2
	else:
		seasonIcon.frame = 3
	updateDay()

func updateMoney(value):
	moneyText.text = str(value)
