extends  Plant

class_name pickled_herring

const herring1 = preload("res://Sprites/Plants/Fish/fish_1.png")
const herring2 = preload("res://Sprites/Plants/Fish/fish_2.png")
const herring3 = preload("res://Sprites/Plants/Fish/fish_3.png")
const herring4 = preload("res://Sprites/Plants/Fish/fish_4.png")

func _ready() -> void:
	itemId = 3
	maxState = 4

func _set_stage(Stage):
	stage = Stage
	_set_sprite_for_stage(stage)

func _set_sprite_for_stage(stage):
	print("setting sprite" + " stage" + str(stage))
	if stage == 1:
		newStage.emit(herring1)
	elif stage == 2:
		newStage.emit(herring2)
	elif stage == 3:
		newStage.emit(herring3)
	elif stage >= 4:
		newStage.emit(herring4)
	else:
		newStage.emit(herring1)
