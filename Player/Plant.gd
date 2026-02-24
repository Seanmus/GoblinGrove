extends Resource
class_name Plant

@export var itemId = 1
@export var maxState = 5
@export var tilePos = 1
@export var stage = 1
signal newStage(sprite)

func _set_stage(Stage):
	stage = Stage
	_set_sprite_for_stage(stage)

func _set_sprite_for_stage(stage):
	return "hi"

func _can_harvest():
	if stage >= maxState:
		Inventory._addItem(itemId)
		call_deferred("queue_free")
		return true

	else:
		return false
