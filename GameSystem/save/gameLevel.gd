extends Resource

class_name  InventorySave


@export var inventory:Resource

const SAVE_GAME_PATH := "user://saveInventory.tres"



func writeSaveFile()->void:
	var error = ResourceSaver.save(self,SAVE_GAME_PATH)
	if error != OK:
		return
	
func loadSaveFile()->Resource:
	return ResourceLoader.load(SAVE_GAME_PATH,"",0)
	

		
func saveFileExists()->bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)
