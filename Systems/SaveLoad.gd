extends Node

const SAVE_PATH = "user://SaveFile.tres"
var SaveFileData : SaveDataResource = SaveDataResource.new()


func _init() -> void:
	#Clears the save file
	#SaveFileData = SaveDataResource.new()
	#_save()
	if !FileAccess.file_exists(SAVE_PATH):
		_save()
		
func _ready() -> void:
	_load()

func _save():
	SaveFileData.day = FarmController.days
	SaveFileData.inventory = Inventory.inventory.duplicate(true)
	SaveFileData.farmdata = FarmController.farmland.duplicate(true)
	SaveFileData.money = Inventory.money
	ResourceSaver.save(SaveFileData, SAVE_PATH)
	print("Saving" + str(SaveFileData.money))

func _load():
	if FileAccess.file_exists(SAVE_PATH):
		print("loading data" + str(SaveFileData.farmdata))
		SaveFileData = ResourceLoader.load(SAVE_PATH).duplicate(true)
		FarmController.days = SaveFileData.day
		Inventory.inventory = SaveFileData.inventory.duplicate(true)
		#FarmController.farmland = SaveFileData.farmdata.duplicate(true)
		Inventory.money = SaveFileData.money
