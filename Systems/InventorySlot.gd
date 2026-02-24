extends Resource


class_name inventorySlot

@export var item : item
@export var count : int
	
func _init(_item : item = Items.items[1], _count := 0) -> void:
	item = _item
	count = _count
