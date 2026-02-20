extends CharacterBody2D

var animation_speed = 3
var moving = false
var tile_size = 16
var last_input
var holdTimer = 0
@export var ray: RayCast2D


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	if input_dir.length() > 0:
		holdTimer += delta
		holdTimer = clamp(holdTimer, 0, 0.4)
		if moving || holdTimer < 0.2:
			return
		else:
			last_input = input_dir
			$AnimationTree.set("parameters/blend_position", last_input)
			if(abs(input_dir.x) > abs(input_dir.y)):
				_move(Vector2(input_dir.x, 0).normalized())
			else:
				_move(Vector2(0, input_dir.y).normalized())

	else:
		holdTimer -= delta
		holdTimer = clamp(holdTimer, 0, 0.4)
		if !moving:
			print(delta)
			print(last_input)
			$AnimationTree.set("parameters/blend_position", Vector2(0,0))
			$AnimationTree.set("parameters/4/blend_position", last_input)
		

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
	
