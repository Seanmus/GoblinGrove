extends CharacterBody2D

var animation_speed = 3
var moving = false
var tile_size = 16
var last_input = Vector2(0,0)
var holdTimer = 0
@export var ray: RayCast2D
@export var soilLayer : TileMapLayer


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	if input_dir.length() > 0:
		holdTimer += delta
		holdTimer = clamp(holdTimer, 0, 0.45)
		last_input = input_dir.normalized()
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
			var tile_pos = soilLayer.local_to_map(Vector2(global_position.x + last_input.x * 16, global_position.y + last_input.y * 16))
			var tileType = soilLayer.get_cell_atlas_coords(tile_pos)
			#waters the soil
			if tileType == Vector2i(0,2) && Input.is_action_just_pressed("click"):
				soilLayer._WaterTile(tile_pos)
			$AnimationTree.set("parameters/blend_position", Vector2(0,0))
			$AnimationTree.set("parameters/4/blend_position", last_input)
			if (tileType == Vector2i(0,2) || tileType == Vector2i(1,2)) and Input.is_action_just_pressed("Plant"):
				print("planting")
				if soilLayer._CanPlantTile(tile_pos):
					soilLayer._Plant(1, Vector2(global_position.x + last_input.x * 16, global_position.y + last_input.y * 16), 1, tile_pos)

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
	
