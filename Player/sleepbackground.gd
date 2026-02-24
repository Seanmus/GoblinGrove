extends TextureRect


func _ready() -> void:
	FarmController.newDay.connect(_NewDay)

func _NewDay():
	$SleepAnim.play("sleep")
