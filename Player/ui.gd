extends Control

var inventoryOpen = false
@export var indicator : Control
@export var indicatorBack : Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		if inventoryOpen:
			indicator.visible = false
			indicatorBack.visible = false
		else:
			indicator.visible = true
			indicatorBack.visible = true
		inventoryOpen = !inventoryOpen
