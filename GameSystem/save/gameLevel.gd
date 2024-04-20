extends Resource

class_name  InventorySave


@export var inventory:Resource

const SAVE_GAME_PATH := "user://saveInventory.tres"



func writeSaveFile()->void:
	var error = ResourceSaver.save(self,SAVE_GAME_PATH)
	if error != OK:
		print("Failed to save resource: %s" % error)
	
func loadSaveFile()->Resource:
	return ResourceLoader.load(SAVE_GAME_PATH,"",0)
	
	
 
		
func saveFileExists()->bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)

#class_name GameLevelSave
#
#@export var currentLevel: PackedScene
#
#func _init(gameLevel:GameLevel=null):
	#if gameLevel!= null:
		#saveGameLevelState(gameLevel)
#
#func saveGameLevelState(gameLevel:GameLevel):
	#var state = PackedScene.new()
	#for child in gameLevel.find_children("","Node"):
		#child.owner = gameLevel
		#
	#state.pack(gameLevel)
	#currentLevel = state
	#
#func loadGameLevelState(gameLevel:GameLevel):
	#var world: GameLevel = gameLevel.get_parent()
	#var loadedState = currentLevel.instantiate()
	#if not gameLevel is GameLevel:
		#return false
	#gameLevel.propagate_call("queue_free")
	#gameLevel.replace_by(loadedState)
	#world = loadedState
