extends Control

@onready var player: Player = get_tree().get_first_node_in_group("players")
@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")
@onready var animalLabel:Label = $NinePatchRect/MarginContainer/VBoxContainer/animalLabel
@onready var animalLeftLabel:Label = $NinePatchRect/MarginContainer/VBoxContainer/animalLeftLabel
@onready var cropsLabel:Label = $NinePatchRect/MarginContainer/VBoxContainer/cropsLabel
@onready var cropsDiedLabel:Label = $NinePatchRect/MarginContainer/VBoxContainer/cropsDiedLabel
@onready var profitLabel:Label = $NinePatchRect/MarginContainer/VBoxContainer/profitLabel
@onready var rewardOne:Sprite2D =$NinePatchRect/MarginContainer/VBoxContainer/Panel/TextureRect/CenterContainer/Sprite2D
@onready var rewardTwo:Sprite2D =$NinePatchRect/MarginContainer/VBoxContainer/Panel/TextureRect2/CenterContainer/Sprite2D
@onready var rewardThree:Sprite2D =$NinePatchRect/MarginContainer/VBoxContainer/Panel/TextureRect3/CenterContainer/Sprite2D

@export var rewards:Dictionary

var UIopened:bool = false
var rewardItemOne:Item
var rewardItemTwo:Item
var rewardItemThree:int
signal opened
signal closed

func _ready():
	SeasonSummary.connect("seasonSummary",displaySeasonSummary)
	
func displaySeasonSummary(animals,animalsLeft,cropsPlanted,cropsDied,totalProfit):
	animalLabel.text = str("Animals on the farm: ",animals)
	animalLeftLabel.text =  str("Animals that left the farm: ",animalsLeft)
	cropsLabel.text =  str("Crops planted: ",cropsPlanted)
	cropsDiedLabel.text =  str("Crops that wilted away: ",cropsDied)
	profitLabel.text =  str("Total profit: ",totalProfit)
	displayRewards()
	openUI()

func displayRewards():
	var season = TimeManager.getSeason()
	
	rewardItemOne = rewards[season][0]
	rewardItemTwo = rewards[season][1]
	rewardItemThree = rewards[season][2]
	
	rewardOne.texture = rewardItemOne.itemImage
	rewardTwo.texture = rewardItemTwo.itemImage
	
func openUI():
	visible = true
	UIopened = true
	opened.emit()
	
func closeUI():
	visible = false
	UIopened = false
	closed.emit()


func _on_button_pressed():
	playerInventory.addItemsToInventory(rewardItemOne,1)
	playerInventory.addItemsToInventory(rewardItemTwo,1)
	player.increaseMoney(rewardItemThree)
	closeUI()
