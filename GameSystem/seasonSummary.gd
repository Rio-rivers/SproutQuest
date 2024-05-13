extends Node

signal seasonSummary(animals,animalsLeft,cropsPlanted,cropsDied,totalProfit)

var animals: int = 0
var animalsLeft: int = 0
var cropsPlanted: int = 0
var cropsDied:int = 0
var totalMoneyMade: int = 0 
var totalMoneySpent: int = 0 
var profit:int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.connect("newSeason",showSummaryGUI)

func showSummaryGUI(_season):
	getAnimals()
	profit = totalMoneyMade - totalMoneySpent
	emit_signal("seasonSummary",animals,animalsLeft,cropsPlanted,cropsDied,profit)
	
	animals = 0
	animalsLeft = 0
	cropsPlanted = 0
	cropsDied = 0
	totalMoneyMade= 0 
	totalMoneySpent = 0 
	profit = 0

func getAnimals():
	animals = get_tree().get_nodes_in_group("animals").size()
	return animals
