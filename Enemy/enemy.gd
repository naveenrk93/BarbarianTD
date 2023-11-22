extends PathFollow3D

@export var speed:float = 5
@export var max_health := 50
@export var gold_value :=15

@onready var flash_animation: AnimationPlayer = $FlashAnimation

@onready var bank = get_tree().get_first_node_in_group("Bank")

var current_health: int:
	get:
		return current_health
	set(health_value):
		if health_value < current_health:
			flash_animation.play("damage_taken")
		current_health = health_value
		if current_health < 1:
			bank.current_gold += gold_value;
			queue_free()
		
@onready var base = get_tree().get_first_node_in_group("Base")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		base.take_damage()
		queue_free()
