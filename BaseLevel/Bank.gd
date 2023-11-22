extends MarginContainer

@onready var gold_label: Label = $GoldLabel

@export var starting_gold := 150

var current_gold:= 0:
	set(value):
		current_gold = max(value, 0)
		gold_label.text = "Gold: " + str(current_gold)
		
func _ready() -> void:
	current_gold = starting_gold
