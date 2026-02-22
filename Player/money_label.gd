extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.inventoryUpdated.connect(_UpdateLabel)
	_UpdateLabel()


func _UpdateLabel():
	text = "G:" + str(Inventory.money)
