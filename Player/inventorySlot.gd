extends Control

@export var slotNumber : int
@onready var icon = $icon
@onready var label = $icon/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.inventoryUpdated.connect(_RefreshDisplay)
	_RefreshDisplay()
		
func _RefreshDisplay():
	if(Inventory.inventory.has(slotNumber)):
		print(str(Inventory.inventory))
		if Inventory.inventory[slotNumber].item.type != 1:
			icon.texture = load(Inventory.inventory[slotNumber].item.texture)
			label.text = str(Inventory.inventory[slotNumber].count)
		else:
			label.text = ""
	else:
		label.text = ""
		icon.texture = null
