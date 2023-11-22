extends Node3D

@export var projectile: PackedScene
@export var turret_range:float = 10.0
@onready var recoil_animation: AnimationPlayer = $RecoilAnimation


@onready var turret_barrel: MeshInstance3D = $TurretBase/TurretBarrel
@onready var turret_base: MeshInstance3D = $TurretBase
@onready var cannon: Node3D = $TurretBase/TurretHead/Cannon

var enemy_path: Path3D
var target: PathFollow3D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		recoil_animation.play("Recoil")
		shot.global_position = cannon.global_position
		shot.direction = turret_base.global_transform.basis.z
	
func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if enemy.progress > best_progress:
				var distance := global_position.distance_to(enemy.global_position)
				if distance < turret_range:
					best_progress = enemy.progress
					best_target = enemy
	return best_target
