extends Node

class_name SaveGame

@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")

var loadOldWorld: bool = false

var _save: InventorySave = InventorySave.new()

func controlPanel():
	if loadOldWorld:
		loadInventorySave()
		load_game()
	else:
		createNewSave()
	loadOldWorld = false

func createNewSave():
	_save = InventorySave.new()
	_save.inventory = InventoryTwo.new()
	#_save.writeSaveFile()
	playerInventory.loadInventory(_save.inventory.items)
	
func loadInventorySave():
	if _save.saveFileExists():
		_save = _save.loadSaveFile() as InventorySave
		playerInventory.loadInventory(_save.inventory.items)
	else:
		createNewSave()
	
	print("PLAYER INVENTORY", playerInventory.items)

func saveToInventorySave():
	#if _save.saveFileExists():
		_save.inventory.items = {}
		_save.inventory.items = playerInventory.items
		_save.writeSaveFile()
		

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("saveable")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)
		
func load_game():
	print("LOAD CALLED")
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	var save_nodes = get_tree().get_nodes_in_group("saveable")
	var player: Player
	for i in save_nodes:
		if !(i is Player):
			i.queue_free()
		else:
			player = i

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		
		var new_object = load(node_data["filename"]).instantiate()
		if "money" not in node_data:
			
			get_node(node_data["parent"]).add_child(new_object)
			
			
		else:
			new_object = player
		new_object.position = Vector2(node_data["posX"], node_data["posY"])
		
		
	
		# Now we set the remaining variables.
		for key in node_data.keys():
			if key in ["filename", "parent", "posX", "posY", "Inventory"]:
				continue
			new_object.set(key, node_data[key])
		if new_object is Animal:
				new_object.updateAnimations()
		elif new_object is Player:
			new_object.increaseMoney(0)
