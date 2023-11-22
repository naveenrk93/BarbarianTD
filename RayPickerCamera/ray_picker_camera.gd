extends Camera3D

@export var gridmap: GridMap;
@export var turret_manager: Node3D;
@export var turret_cost := 100

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank = get_tree().get_first_node_in_group("Bank")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 1000.0
	ray_cast_3d.force_raycast_update()

	if ray_cast_3d.is_colliding() and bank.current_gold >= turret_cost:
		var collider = ray_cast_3d.get_collider()
		var collision_point = ray_cast_3d.get_collision_point()
		if collider is GridMap:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			if Input.is_action_just_pressed("click"):
				var cell = gridmap.local_to_map(collision_point)
				var cell_item = gridmap.get_cell_item(cell);
				if cell_item == 0:
					var tile_position = gridmap.map_to_local(cell)
					turret_manager.build_turret(tile_position)
					gridmap.set_cell_item(cell, 1)
					bank.current_gold -= turret_cost
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
