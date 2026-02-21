extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FarmController._SetupFarmLand(self)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		_LoadFarmland()
	if Input.is_action_just_pressed("debug2"):
		_Debug()


func _Debug():
	var tiles = get_used_cells()
	for tile in tiles:
		var tileType = get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2) || tileType == Vector2i(1,2):
			set_cell(tile, 0, Vector2(1,2))



func _LoadFarmland():
	var tiles = get_used_cells()
	for tile in tiles:
		var tileType = get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2) || tileType == Vector2i(1,2):
			var farmdata = FarmController.farmland[tile]
			if farmdata.watered == true:
				set_cell(tile, 0, Vector2(1,2))
			else:
				set_cell(tile, 0, Vector2(0,2))
