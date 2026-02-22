extends Node
#initalize inventory with 5 seeds
@onready var inventory = {1 : inventorySlot.new(Items.items[5], 1) }

signal inventoryUpdated

class inventorySlot:
	var item
	var count
	
	func _init(_item, _count) -> void:
		item = _item
		count = _count

func _ready() -> void:
	print(str(inventory))

func _addItem(itemId):
	#use a for int i loop to go through and find the next open slot
	#maybe start at 6?
	print("adding item " + str(Items.items[itemId].description))
	inventory.get_or_add(6, inventorySlot.new(Items.items[itemId], 1))
	emit_signal("inventoryUpdated")
