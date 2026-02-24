extends Resource
class_name  FarmData

@export var watered : bool
@export var plantIndex : int
@export var stage : int
@export var plantType : Plant
	
func _init(_watered := false, _plant := 0, _stage: = 0, _plantType := Onion.new()):
	watered = _watered
	plantIndex = _plant
	stage = _stage
	plantType = _plantType
