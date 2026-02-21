extends TextureRect

@export var time_label :Label
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = FarmController.hour * deg_to_rad(15)
	var suffix = "AM"
	if(FarmController.hour >= 12):
		suffix = "PM"
	time_label.text = "%02d" %FarmController.hour + ":" + "%02d" %FarmController.minute + suffix
