extends Node3D

@export var max_health: int = 5

@onready var health: Label3D = $Health
var current_health:int:
	set(health_value):
		current_health = health_value
		health.text = str(current_health) + "/" + str(max_health)
		var red = Color.RED;
		var white = Color.WHITE;
		health.modulate = red.lerp(white, float(current_health) / float(max_health))
		if current_health < 1:
			get_tree().reload_current_scene()
	get:
		return current_health
		
func _ready() -> void:
	current_health = max_health

func take_damage() -> void:
	current_health -= 1

	
