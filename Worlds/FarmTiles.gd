extends TileMapLayer

const onionPlant = preload("res://Player/onion.tscn")
const herringPlant = preload("res://Player/herring.tscn")
@onready var plantParent = $PlantParent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FarmController._SetupFarmLand(self)
	print(str(FarmController.farmland))
	FarmController.newDay.connect(_NewDay)
	#_LoadPlants()
	#_LoadFarmland()

#remove duplicated code with new day later
func _LoadPlants():
	_DeleteAllPlants()
	var tiles = get_used_cells()
	for tile in tiles:
		var tileType = get_cell_atlas_coords(tile)
		if (tileType == Vector2i(0,2) || tileType == Vector2i(1,2)) && FarmController.farmland.has(tile):
			var farmdata = FarmController.farmland[tile]
			var tile_pos = Vector2(0,0)				
			set_cell(tile, 0, Vector2(0,2))
			print(farmdata)
			if(farmdata.plantIndex != 0):
				print("regrowing")
				_Plant(farmdata.plantIndex, map_to_local(tile), farmdata.stage, tile)


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
	if farmland.plantIndex == 0:
		print("can plant")
		return true
	else:
		print("no plant allowed")
		return false

func _Plant(plantType, tile_pos, stage, farm_pos):
	var farmland = FarmController.farmland[farm_pos]
	farmland.plantIndex = plantType
	farmland.stage = stage
	print("adding plant")
	var newPlant
	if(plantType == 2):
		newPlant = onionPlant.instantiate()
	if(plantType == 4):
		newPlant = herringPlant.instantiate()
	farmland.plantType = newPlant
	plantParent.add_child(newPlant)
	newPlant.position = tile_pos
	print(newPlant)
	newPlant._set_stage(stage)

func _can_harvest(farm_pos):
	if FarmController.farmland.has(farm_pos):
		var farmland = FarmController.farmland[farm_pos]
		if farmland.plantType != null:
			if farmland.plantType._can_harvest():
				farmland.stage = 0
				farmland.plantType = null
				farmland.plantIndex = 0
				return true
			else:
				return false
		return false
	
func _NewDay():
	_DeleteAllPlants()
	var tiles = get_used_cells()
	for tile in tiles:
		var tileType = get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2) || tileType == Vector2i(1,2):
			var farmdata = FarmController.farmland[tile]
			var tile_pos = Vector2(0,0)

				#Grow Plant
					
			set_cell(tile, 0, Vector2(0,2))
			if(farmdata.plantIndex != 0):
				print("regrowing")
				_Plant(farmdata.plantIndex, map_to_local(tile), farmdata.stage, tile)	

func _DeleteAllPlants():
	for child in plantParent.get_children():
		child.queue_free()
