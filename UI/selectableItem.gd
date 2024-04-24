# displays the item that a player is storing, updates equipped item
@tool

extends TextureButton
class_name  itemBarButton
#signal buttonPressed(item)
@export var item : Item:
	set(itemSlot):
		item = itemSlot
		texture_normal = item.itemImage

var equip : Equip



#if item is equipabble, set item as equipped
func onPress():
	if item is Equippables:
		if equip != null:
			equip.setTool(item)

