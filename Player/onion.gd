extends  Plant

const onion1 = preload("res://Sprites/Plants/Onion/onion_1.png")
const onion2 = preload("res://Sprites/Plants/Onion/onion_2.png")
const onion3 = preload("res://Sprites/Plants/Onion/onion_3.png")
const onion4 = preload("res://Sprites/Plants/Onion/onion_4.png")
const onion5 = preload("res://Sprites/Plants/Onion/onion_5.png")

func _ready() -> void:
	itemId = 1

func _set_stage(Stage):
	stage = Stage
	_set_sprite_for_stage(stage)

func _set_sprite_for_stage(stage):
	print("setting sprite" + " stage" + str(stage))
	if stage == 1:
		$PlantSprite.texture = onion1
	elif stage == 2:
		$PlantSprite.texture = onion2
	elif stage == 3:
		$PlantSprite.texture = onion3
	elif stage == 4:
		$PlantSprite.texture = onion4
	elif stage >= 5:
		$PlantSprite.texture = onion5
	else:
		$PlantSprite.texture = onion1
