extends Resource

class_name ShopInventory

var price: int
var seasons: Array[String]
var sellable: bool
@export var shopItems : Dictionary = {Item:{}}
#@export var shopItems : Dictionary = {Item:{"price":int,"seasons":[seasons],"sellable":bool}}
# Called when the node enters the scene tree for the first time.


