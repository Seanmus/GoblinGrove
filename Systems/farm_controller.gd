extends Node

var tileMap
var farmland = {}
var hour = 6
var minute = 0
var days = 0
var timer = 0
var facing_dir = Vector2(0,0)

signal newDay
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print("Farmland data farm controller" + str(farmland))

func _process(delta: float) -> void:
	timer += delta
	if timer >= 0.5:
		timer -= 0.5
		minute += 1
	if minute >= 60:
		hour += 1
		minute = 0
	if hour >= 24:
		_NewDay()

func _NewDay():
	timer = 0
	minute = 0
	hour = 6
	days += 1
	
	for farmdataKeys in farmland:
		var farmdata = farmland[farmdataKeys]
		if farmdata.watered == true:
			farmdata.watered = false
			farmdata.stage += 1
	newDay.emit()


func _SetupFarmLand(soilLayer):
	tileMap = soilLayer
	var tiles = soilLayer.get_used_cells()
	for tile in tiles:
		var tileType = soilLayer.get_cell_atlas_coords(tile)
		if tileType == Vector2i(0,2):
			var newFarmLand = FarmData.new(false, 0, 0, null)
			if !farmland.has(tile):
				farmland.get_or_add(tile, newFarmLand)
			
