extends AnimatedSprite2D


func _ready():
	TimeManager.connect("newSeason",changeTexture)
	TimeManager.connect("loadedcurrentSeason",changeTexture)

func changeTexture(season):
	if season == 4:
		frame = 2
	elif season == 3:
		frame = 1
	else:
		frame = 0
