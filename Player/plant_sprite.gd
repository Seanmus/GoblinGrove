extends Node2D

@export var plant : Plant

func _ready() -> void:
	plant._set_stage(plant.stage)
	plant.newStage.connect(_on_plant_new_stage)

func _on_plant_new_stage(sprite: Variant) -> void:
	$PlantSprite.texture = sprite
