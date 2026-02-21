extends Node

var farmland = {}
# Called when the node enters the scene tree for the first time.

class FarmData:
	var watered : bool
	var plant : int
	var stage : int
	
	func _init(_watered, _plant, _stage):
		watered = _watered
		plant = _plant
		stage = _stage

func _WaterTile(soilLayer, tile_pos):
	soilLayer.set_cell(tile_pos, 0, Vector2(1,2))
	farmland[tile_pos].watered = true
		


func _SetupFarmLand(soilLayer):
	var tiles = soilLayer.get_used_cells()
	for tile in tiles:
		var tileType = soilLayer.get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2):
			var newFarmLand = FarmData.new(false, 0, 0)
			farmland.get_or_add(tile, newFarmLand)
			
