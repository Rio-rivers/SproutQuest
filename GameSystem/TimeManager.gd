extends Node
# game day starts around 8am 

const GAME_DAY_DURATION = 10 #840.0
const GAME_SEASON_DURATION = 2#23520.0

enum seasons { SPRING = 1, SUMMER =2, FALL=3, WINTER=4 }

var currentTime = 0
var currentDay = 1
var currentSeason = seasons.SPRING

#10pm would be 490 seconds, 6am would be 770 seconds

signal newDay
signal newSeason(currentSeason)

func _ready():
	set_process(true)

func _process(delta):
	updateTime(delta)
	

func updateTime(timePassed):
	currentTime += timePassed
	if currentTime >= GAME_DAY_DURATION:
		currentTime = 0
		currentDay += 1
		print(" ")
		#print("DAY: ", currentDay)
		#print("CURRENT SEASON: ", currentSeason)
		emit_signal("newDay")
		if currentDay > GAME_SEASON_DURATION:
			nextSeason()

func nextSeason():
	currentDay = 1
	currentSeason = (currentSeason % 4) + 1
	#print(" ")
	#print("DAY: ", currentDay)
	#print("NEW SEASON: ", currentSeason)
	
	
	emit_signal("newSeason",currentSeason)
	
	
func getSeason()->int:
	return currentSeason
	
func getDay()->int:
	return currentDay
