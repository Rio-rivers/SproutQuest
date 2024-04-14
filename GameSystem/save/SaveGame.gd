extends Resource

class_name SaveGame

@export var player:Resource
@export var inventory:Resource
@export var animals: Resource
@export var shop: Resource
@export var itemResources: Resource

const SAVE_GAME_PATH := "user://save.tres"


var playerPosition: Vector2

func writeSaveFile()->void:
	var error = ResourceSaver.save(self,SAVE_GAME_PATH)
	if error != OK:
		print("Failed to save resource: %s" % error)
	
func loadSaveFile()->Resource:
	if ResourceLoader.has_cached(SAVE_GAME_PATH):
		return ResourceLoader.load(SAVE_GAME_PATH,"",2)
	else:
		print("No cached resource found.")
		return null
