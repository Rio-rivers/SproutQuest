extends Node

class_name SaveGame

@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")

var loadOldWorld: bool = false

var _save: InventorySave = InventorySave.new()

const lines: Array[String]= ["HELLO!","Its nice to meet you" ,"I am Pip" , "I see that you are new here", "let me go over the basics ...","press 'E' for the market and tasks","press 'I' for your inventory", "try buying some tools and feed to start off with","well thats it for now ...", "Im excited to see what you can do with this place!"]

func controlPanel():
	if loadOldWorld:
		loadInventorySave()
		loadGame()
	else:
		createNewSave()
	loadOldWorld = false

func createNewSave():
	TextManager.resetDialog()
	_save = InventorySave.new()
	_save.inventory = InventoryTwo.new()
	playerInventory.loadInventory(_save.inventory.items)
	TextManager.runDialog(lines)
	
	
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
		"currentSeason": TimeManager.currentSeason,
		"type": "TimeManager"
	}
	var dialogTutorial ={
		"animalTutorial": TextManager.animalTutorial,
		"farmingTutorial": TextManager.farmingTutorial,
		"type": "TextManager"
	}
	var dialogTutorialJsonString = JSON.stringify(dialogTutorial)
	saveGame.store_line(dialogTutorialJsonString)
	
	var timeManagerJsonString = JSON.stringify(timeManagerDict)
	saveGame.store_line(timeManagerJsonString)
	
	for node in saveNodes:
		if  not node.has_method("save"):
			continue
 
		var nodeData = node.call("save")
		var jsonString = JSON.stringify(nodeData)
		saveGame.store_line(jsonString)

func loadGame():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	var gameLevel = get_node("/root/GameLevel")
	
	
	var saveNodes = get_tree().get_nodes_in_group("saveable")
	var player: Player
	var _trough
	for node in saveNodes:
		if node is Player:
			player = node
		elif node is WaterTrough or node is FoodTrough:
			_trough = node
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
			var parent = get_node(nodeData["parent"])
			parent.add_child(newObject)
			if newObject is TilledSoil:
					parent.setPosition(newObject,Vector2(nodeData["posX"], nodeData["posY"]))
			else:
				newObject.position = Vector2(nodeData["posX"], nodeData["posY"])
		elif "type" in nodeData:
			if nodeData["type"] == "WaterTrough": 
				newObject = gameLevel.get_node("worldObjects/waterTrough")
			elif nodeData["type"] == "FoodTrough":
				newObject = gameLevel.get_node("worldObjects/foodTrough")
			elif nodeData["type"] == "Player":
				newObject = gameLevel.get_node("player")
				player.position = Vector2(nodeData["posX"], nodeData["posY"])
			elif nodeData["type"] == "TextManager":
				newObject = TextManager
				TextManager.farmingTutorial = bool(nodeData["farmingTutorial"])
				TextManager.animalTutorial = bool(nodeData["animalTutorial"])
			else:
				newObject = TimeManager
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
		elif newObject is WaterTrough or newObject is FoodTrough:
			newObject.updateTrough()
