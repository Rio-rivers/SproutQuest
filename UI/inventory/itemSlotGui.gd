#this file deals with each slot visually
extends Panel


@onready var backgroundImage: Sprite2D = $background
@onready var itemImage: Sprite2D = $item

func updateSlot(item: Object) -> void:
	pass
	# If there is an item, change the look of the slot
	#if item:
		#itemImage.visible = true
		#backgroundImage.frame = 1
		#if item is Item or item is InventoryItem:
			#var item_resource = item as Resource 
			#if item is Item:
				#itemImage.texture = item_resource.itemImage
			#else:
				#itemImage.texture = item_resource.texture	
		#else:
			## Handle other cases or throw an error
			#print("Unsupported item type")
	#else:
		#itemImage.visible = false
		#backgroundImage.frame = 0
