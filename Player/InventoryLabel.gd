extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.inventoryUpdated.connect(_UpdateLabel)
	_UpdateLabel()

func _UpdateLabel():
	if(Inventory.inventory.has(Inventory.selectedItem)):
		text = "Desc:" + Inventory.inventory[Inventory.selectedItem].item.description + "\n Value:" + str(Inventory.inventory[Inventory.selectedItem].item.salePrice) 
	else:
		text = "Desc: 0" + "\n Value: 0"
