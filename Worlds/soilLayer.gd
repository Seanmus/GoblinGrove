extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FarmController._SetupFarmLand(self)


func _LoadFarmland():
	var tiles = get_used_cells()
	for tile in tiles:
		var tileType = get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2):
			var farmdata = FarmController.farmland[tile]
			if farmdata.watered == true:
				set_cell(tile, 0, Vector2(1,2))
