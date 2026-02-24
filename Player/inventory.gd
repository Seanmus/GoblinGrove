extends Node
#initalize inventory with 5 seeds
class_name Inventory_Class
@export var inventory = {}

signal inventoryUpdated
var selectedItem = 1
var money = 0



func _UpdateSelectedItem(itemSlot):
	selectedItem = itemSlot
	emit_signal("inventoryUpdated")

func _ready() -> void:
	print(str(inventory))

func _buyItem(itemId):
	if(money >= Items.items[itemId].price):
		money -= Items.items[itemId].price
		_addItem(itemId)

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

func _sellItem(itemSlot):
	money += inventory[itemSlot].item.salePrice
	print("Selling item " + inventory[itemSlot].item.description)
	print("Money total " + str(money))
	_useItem(itemSlot)
