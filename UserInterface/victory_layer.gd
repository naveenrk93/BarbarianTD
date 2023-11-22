extends CanvasLayer

@onready var star_1: TextureRect = %Star1
@onready var star_2: TextureRect = %Star2
@onready var star_3: TextureRect = %Star3
@onready var base = get_tree().get_first_node_in_group("Base")
@onready var bank = get_tree().get_first_node_in_group("Bank")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func victory() -> void:
	self.visible = true;
	if base.current_health == base.max_health or bank.current_gold > 500:
		star_2.modulate = Color.WHITE
	if base.current_health == base.max_health and bank.current_gold > 500:
		star_3.modulate = Color.WHITE

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
