extends Node2D
class_name Plant

var itemId
var maxState = 5
var tilePos = 1
var stage = 1


func _set_stage(Stage):
	stage = Stage
	_set_sprite_for_stage(stage)

func _set_sprite_for_stage(stage):
	return "hi"

func _can_harvest(stage):
	if stage >= maxState:
		return true
	else:
		return false
