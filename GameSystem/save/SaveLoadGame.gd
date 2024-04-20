extends Node

class_name SaveGame

@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")

var loadOldWorld: bool = false

var _save: InventorySave = InventorySave.new()

func controlPanel():
	if loadOldWorld:
		loadInventorySave()
		loadGame()
	else:
		createNewSave()
	loadOldWorld = false

func createNewSave():
	_save = InventorySave.new()
	_save.inventory = InventoryTwo.new()
	playerInventory.loadInventory(_save.inventory.items)
	
	
func loadInventorySave():
	if _save.saveFileExists():
		_save = _save.loadSaveFile() as InventorySave
		playerInventory.loadInventory(_save.inventory.items)
	else:
		createNewSave()


func saveToInventorySave():
		_save.inventory.items = {}
		_save.inventory.items = playerInventory.items
		_save.writeSaveFile()

		
func saveGame():
	var saveGame = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var saveNodes = get_tree().get_nodes_in_group("saveable")
	
	var timeManagerDict = {
		"currentTime": TimeManager.currentTime,
		"currentDay": TimeManager.currentDay,
		"currentSeason": TimeManager.currentSeason
	}
	var jsonString = JSON.stringify(timeManagerDict)

	saveGame.store_line(jsonString)
	for node in saveNodes:
		if  not node.has_method("save"):#node.scene_file_path.is_empty() or
			continue
 
		var nodeData = node.call("save")
		jsonString = JSON.stringify(nodeData)
		saveGame.store_line(jsonString)


func loadGame():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var saveNodes = get_tree().get_nodes_in_group("saveable")
	var player: Player
	for node in saveNodes:
		if node is Player:
			player = node
		else:
			node.queue_free()
	var saveGame = FileAccess.open("user://savegame.save", FileAccess.READ)
	while saveGame.get_position() < saveGame.get_length():
		var jsonString = saveGame.get_line()
		var json = JSON.new()
		var parseResult = json.parse(jsonString)
		if parseResult != OK:
			continue
		
		var nodeData = json.get_data()
		var newObject = null

		if "filename" in nodeData:
			newObject = load(nodeData["filename"]).instantiate()
		else:
			newObject = TimeManager

		if "money" not in nodeData and "currentDay" not in nodeData:
			var parent = get_node(nodeData["parent"])
			parent.add_child(newObject)
			if "posX" in nodeData:
				if newObject is TilledSoil:
					parent.setPosition(newObject,Vector2(nodeData["posX"], nodeData["posY"]))
				else:
					newObject.position = Vector2(nodeData["posX"], nodeData["posY"])
		elif "money" in nodeData:
			player.position = Vector2(nodeData["posX"], nodeData["posY"])
		elif "currentDay" in nodeData:
			TimeManager.currentDay = int(nodeData["currentDay"])
			TimeManager.currentSeason = int(nodeData["currentSeason"])
			TimeManager.loadDaySeason()

		for key in nodeData.keys():
			if key not in ["filename", "parent", "posX", "posY", "Inventory", "currentSeason", "currentDay"]:
				newObject.set(key, nodeData[key])

		if newObject is Animal:
			newObject.updateAnimations()
		elif newObject is Player:
			player.money = nodeData["money"]
			player.increaseMoney(0)
			
		elif newObject is PlantedPlant:
			newObject.checkAge()
			
		elif newObject is TilledSoil and nodeData["watered"]:
			newObject.waterSoil()
