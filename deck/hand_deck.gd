extends "res://deck/deck.gd"

func _ready() -> void:
	$ProgressBar.max_value = maxWeight
	update_weight()
	pass
