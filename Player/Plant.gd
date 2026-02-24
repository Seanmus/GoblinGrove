extends Resource
class_name Plant

@export var itemId = 1
@export var maxState = 5
@export var tilePos = 1
@export var stage = 1
signal newStage(sprite)
signal harvested
func _set_stage(Stage):
	stage = Stage
	_set_sprite_for_stage(stage)

func _set_sprite_for_stage(stage):
	return "hi"

func _can_harvest():
	if stage >= maxState:
		Inventory._addItem(itemId)
		harvested.emit()
		return true


	else:
		return false
