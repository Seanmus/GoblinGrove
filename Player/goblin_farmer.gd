extends CharacterBody2D

var animation_speed = 3
var moving = false
var tile_size = 16
var last_input = Vector2(0,0)
var holdTimer = 0

@export var ray: RayCast2D
@export var soilLayer : TileMapLayer
@export var ui : Control

func _physics_process(delta: float) -> void:
	_SelectedItem()
	if Input.is_action_just_pressed("k"):
		Inventory._addItem(1)
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	if input_dir.length() > 0:
		holdTimer += delta
		holdTimer = clamp(holdTimer, 0, 0.45)
		last_input = input_dir.normalized()
		if(abs(input_dir.x) > abs(input_dir.y)):
			$LookRaycast.target_position = Vector2(input_dir.x * 16, 0)
		else:
			$LookRaycast.target_position = Vector2(0, input_dir.y * 16)
		if moving || holdTimer < 0.32:
			return
		else:			
			$AnimationTree.set("parameters/blend_position", last_input)
			if(abs(input_dir.x) > abs(input_dir.y)):
				_move(Vector2(input_dir.x, 0).normalized())
			else:
				_move(Vector2(0, input_dir.y).normalized())

	else:
		holdTimer = 0
		if !moving:
			_UseItems()
			#waters the soil
			$AnimationTree.set("parameters/blend_position", Vector2(0,0))
			$AnimationTree.set("parameters/4/blend_position", last_input)

func _UseItems():
	var tile_pos = soilLayer.local_to_map(Vector2(global_position.x + last_input.x * 16, global_position.y + last_input.y * 16))
	var tileType = soilLayer.get_cell_atlas_coords(tile_pos)
	if Input.is_action_just_pressed("click"):
		if(soilLayer._can_harvest(tile_pos)):
			return
		if($LookRaycast.is_colliding()):
			var detected = $LookRaycast.get_collider()
			if detected is ShippingContainer:
				if !Inventory.inventory.has(Inventory.selectedItem):
					return
				if Inventory.inventory[Inventory.selectedItem].item.type == 2:
					Inventory._sellItem(Inventory.selectedItem)
				
				
	if (tileType == Vector2i(0,2) || tileType == Vector2i(1,2)) && Input.is_action_just_pressed("click"):
		if !Inventory.inventory.has(Inventory.selectedItem):
			return
		if Inventory.inventory[Inventory.selectedItem].item.itemId == 5:
			soilLayer._WaterTile(tile_pos)
		elif Inventory.inventory[Inventory.selectedItem].item.type == 0:
			print("planting")
			if soilLayer._CanPlantTile(tile_pos):
				soilLayer._Plant(Inventory.inventory[Inventory.selectedItem].item.itemId, Vector2(global_position.x + last_input.x * 16, global_position.y + last_input.y * 16), 1, tile_pos)
				Inventory._useItem(Inventory.selectedItem)
				
func _SelectedItem():	
	if Input.is_action_just_pressed("one"):
		ui._HotBarHighlight(1)
		Inventory._UpdateSelectedItem(1)
	if Input.is_action_just_pressed("two"):
		ui._HotBarHighlight(2)
		Inventory._UpdateSelectedItem(2)
	if Input.is_action_just_pressed("three"):
		ui._HotBarHighlight(3)
		Inventory._UpdateSelectedItem(3)
	if Input.is_action_just_pressed("four"):
		ui._HotBarHighlight(4)
		Inventory._UpdateSelectedItem(4)
	if Input.is_action_just_pressed("five"):
		ui._HotBarHighlight(5)
		Inventory._UpdateSelectedItem(5)
			
func _move(input_dir):
	ray.target_position = input_dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
	   	position + 
		input_dir * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
	
