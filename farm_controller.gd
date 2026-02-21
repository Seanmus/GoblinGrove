extends Node

var tileMap
var farmland = {}
var hour = 6
var minute = 0
var days = 0
var timer = 0

signal newDay
# Called when the node enters the scene tree for the first time.

class FarmData:
	var watered : bool
	var plant : int
	var stage : int
	
	func _init(_watered, _plant, _stage):
		watered = _watered
		plant = _plant
		stage = _stage

func _process(delta: float) -> void:
	timer += delta
	if timer >= 0.01:
		timer -= 0.01
		minute += 1
	if minute >= 60:
		hour += 1
		minute = 0
	if hour >= 24:
		hour = 0
		days += 1
		newDay.emit()

func _SetupFarmLand(soilLayer):
	tileMap = soilLayer
	var tiles = soilLayer.get_used_cells()
	for tile in tiles:
		var tileType = soilLayer.get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2):
			var newFarmLand = FarmData.new(false, 0, 0)
			farmland.get_or_add(tile, newFarmLand)
			
