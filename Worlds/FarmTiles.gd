extends TileMapLayer

const onionPlant = preload("res://Player/onion.tscn")
@onready var plantParent = $PlantParent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FarmController._SetupFarmLand(self)
	FarmController.newDay.connect(_NewDay)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		_LoadFarmland()
	if Input.is_action_just_pressed("k"):
		pass
		#_Debug()
		
func _Debug():
	_NewDay()


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
				

func _WaterTile(tile_pos):
	set_cell(tile_pos, 0, Vector2(1,2))
	FarmController.farmland[tile_pos].watered = true

func _CanPlantTile(farm_pos):
	var farmland = FarmController.farmland[farm_pos]
	if farmland.plant == 0:
		print("can plant")
		return true
	else:
		print("no plant allowed")
		return false

func _Plant(plantType, tile_pos, stage, farm_pos):
	var farmland = FarmController.farmland[farm_pos]
	farmland.plant = plantType
	farmland.stage = stage
	print("adding onion")
	var newOnion = onionPlant.instantiate()
	plantParent.add_child(newOnion)
	newOnion.position = tile_pos
	print(newOnion)
	newOnion._set_stage(stage)
	
func _NewDay():
	_DeleteAllPlants()
	var tiles = get_used_cells()
	for tile in tiles:
		var tileType = get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2) || tileType == Vector2i(1,2):
			var farmdata = FarmController.farmland[tile]
			var tile_pos = Vector2(0,0)
			if farmdata.watered == true:
				farmdata.watered = false
				farmdata.stage += 1
				#Grow Plant
					
			set_cell(tile, 0, Vector2(0,2))
			if(farmdata.plant != 0):
				print("regrowing")
				_Plant(farmdata.plant, map_to_local(tile), farmdata.stage, tile)	

func _DeleteAllPlants():
	for child in plantParent.get_children():
		child.queue_free()
