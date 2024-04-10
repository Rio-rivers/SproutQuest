extends NinePatchRect

@export var shopInventory:ShopInventory

# Called when the node enters the scene tree for the first time.
func _ready():
	print_inventory()


func print_inventory():
	print("Inventory Contents:")
	for item in shopInventory.shopItems.keys():
		print("Item: ", item, " Count: ", shopInventory.shopItems[item])
