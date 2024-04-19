extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newSeason",changeTexture)
	TimeManager.connect("loadedcurrentSeason",changeTexture)

func changeTexture(season):
	if season == 3:
		frame = 1
	elif season == 4:
		frame = 2
	else:
		frame = 0
