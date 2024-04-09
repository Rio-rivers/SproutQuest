extends AnimatedSprite2D


func _ready():
	TimeManager.connect("newSeason",changeTexture)


func changeTexture(season):
	if season == 4:
		frame = 1
	else:
		frame = 0
