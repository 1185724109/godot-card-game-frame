extends Control

func _on_new_game_button_down() -> void:
	get_tree().change_scene_to_file("res://name_screen.tscn")
	pass # Replace with function body.
	
	
func _on_continue_game_button_down() -> void:
	Infos.loadPlayerInfo()
	pass # Replace with function body.
