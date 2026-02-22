extends Control

@export var slotNumber : int
@onready var icon = $icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.inventoryUpdated.connect(_RefreshDisplay)
	if(Inventory.inventory.has(slotNumber)):
		print("hi")
		icon.texture = Inventory.inventory[slotNumber].item.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _RefreshDisplay():
	if(Inventory.inventory.has(slotNumber)):
		icon.texture = Inventory.inventory[slotNumber].item.texture
		print(str(Inventory.inventory[slotNumber].item.texture))
