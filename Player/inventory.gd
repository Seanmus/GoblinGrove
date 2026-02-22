extends Node
#initalize inventory with 5 seeds
@onready var inventory = {1 : inventorySlot.new(Items.items[5], 1), 2 : inventorySlot.new(Items.items[2], 5)}

signal inventoryUpdated
var selectedItem = 1


class inventorySlot:
	var item
	var count
	
	func _init(_item, _count) -> void:
		item = _item
		count = _count

func _UpdateSelectedItem(itemSlot):
	selectedItem = itemSlot
	emit_signal("inventoryUpdated")

func _ready() -> void:
	print(str(inventory))

func _addItem(itemId):
	#use a for int i loop to go through and find the next open slot
	#maybe start at 6?
	for i in range(1, 23):
		if inventory.has(i):
			if(inventory[i].item.itemId == itemId):
				inventory[i].count += 1
				emit_signal("inventoryUpdated")
				return
	#if no match is found do add to next open slot
	for i in range(1, 24):
		if !inventory.has(i):
			print("adding item " + str(Items.items[itemId].description))
			inventory.get_or_add(i, inventorySlot.new(Items.items[itemId], 1))
			emit_signal("inventoryUpdated")
			return
	

func _useItem(itemSlot):
	inventory[itemSlot].count -= 1
	print(inventory[itemSlot].item)
	if inventory[itemSlot].count <= 0:
		inventory.erase(itemSlot)
	emit_signal("inventoryUpdated")
