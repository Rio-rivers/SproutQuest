extends Node
# game day starts around 8am 

const GAME_DAY_DURATION = 120
const GAME_SEASON_DURATION = 7
const DAY_TIME:float = GAME_DAY_DURATION / (10/5)
const EVENING_TIME:float = DAY_TIME + (GAME_DAY_DURATION / (10/3))
const NIGHT_TIME:float = EVENING_TIME + (GAME_DAY_DURATION / (10/2))
enum seasons { SPRING = 1, SUMMER =2, FALL=3, WINTER=4 }
enum timeOfDay { DAY = 1, EVENING =2, NIGHT=3}

var currentTimeOfDay = timeOfDay.DAY
var currentTime = 0
var currentDay = 1
var currentSeason = seasons.SPRING


signal newDay
signal newSeason(currentSeason)
signal loadedcurrentDay
signal loadedcurrentSeason(currentSeason)
signal newTimeOfDay(currentTime)

func _ready():
	set_process(true)

func _process(delta):
	currentTime += delta
	if currentTime >= GAME_DAY_DURATION:
		currentTime = 0
		currentDay += 1
		emit_signal("newDay")
		if currentDay > GAME_SEASON_DURATION:
			nextSeason()
	if currentTime <= DAY_TIME and not currentTimeOfDay == timeOfDay.DAY:
		currentTimeOfDay = timeOfDay.DAY
		emit_signal("newTimeOfDay",currentTimeOfDay)
	elif currentTime <= EVENING_TIME and currentTime > DAY_TIME and not currentTimeOfDay == timeOfDay.EVENING:
		currentTimeOfDay = timeOfDay.EVENING
		emit_signal("newTimeOfDay",currentTimeOfDay)
	elif currentTime <= NIGHT_TIME and currentTime > EVENING_TIME and not currentTimeOfDay == timeOfDay.NIGHT:
		currentTimeOfDay = timeOfDay.NIGHT
		emit_signal("newTimeOfDay",currentTimeOfDay)

func changeTimeOfDay():
	currentTimeOfDay= (currentSeason % 3) + 1
	

func nextSeason():
	currentDay = 1
	currentSeason = (currentSeason % 4) + 1
	emit_signal("newSeason",currentSeason)
	
func loadDaySeason():
	emit_signal("loadedcurrentDay")
	emit_signal("loadedcurrentSeason",currentSeason)
	
func getSeason()->int:
	return currentSeason
	
func getTimeOfDay()->int:
	return currentTimeOfDay
	
func getNextSeason():
	return (currentSeason % 4) + 1
	
func getDay()->int:
	return currentDay
