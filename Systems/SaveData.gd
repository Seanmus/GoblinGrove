extends Resource
class_name SaveDataResource

@export var inventory : Dictionary = {1 : inventorySlot.new(Items.items[5], 1), 2 : inventorySlot.new(Items.items[2], 5)}
@export var money : int
@export var day : int
@export var farmdata : Dictionary
