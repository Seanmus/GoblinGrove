extends Control

var inventoryOpen = true
@export var indicator : Control
@export var indicatorBack : Control
@export var inventory : Control
@onready var hotbarIcon = preload("res://Sprites/UI/UIPanel.png")
@onready var hotbarIconHighlight = preload("res://Sprites/UI/UIPanelHighLight.png")

func _HotBarHighlight(icon):
	$ItemBar/ItemBox.texture = hotbarIcon
	$ItemBar/ItemBox2.texture = hotbarIcon
	$ItemBar/ItemBox3.texture = hotbarIcon
	$ItemBar/ItemBox4.texture = hotbarIcon
	$ItemBar/ItemBox5.texture = hotbarIcon
	if icon == 1:
		$ItemBar/ItemBox.texture = hotbarIconHighlight
	elif icon == 2:
		$ItemBar/ItemBox2.texture = hotbarIconHighlight
	elif icon == 3:
		$ItemBar/ItemBox3.texture = hotbarIconHighlight	
	elif icon == 4:
		$ItemBar/ItemBox4.texture = hotbarIconHighlight
	elif icon == 5:
		$ItemBar/ItemBox5.texture = hotbarIconHighlight
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		if inventoryOpen:
			indicator.visible = false
			indicatorBack.visible = false
			inventory.visible = true
		else:
			indicator.visible = true
			indicatorBack.visible = true
			inventory.visible = false
		inventoryOpen = !inventoryOpen
