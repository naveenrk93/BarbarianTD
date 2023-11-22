extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node
@export var victory_layer: CanvasLayer;

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_enemies() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	new_enemy.tree_exited.connect(enemies_defeated)
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()

func _on_stop_spawning_enemies() -> void:
	timer.stop()
	
func enemies_defeated() -> void:
	if timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return;
		print("You won!")
		victory_layer.victory();
		
