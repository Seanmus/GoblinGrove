extends Resource
class_name  FarmData

@export var watered : bool
@export var plantIndex : int
@export var stage : int
@export var plantType : Plant
	
func _init(_watered, _plant, _stage, _plantType):
	watered = _watered
	plantIndex = _plant
	stage = _stage
	plantType = _plantType
