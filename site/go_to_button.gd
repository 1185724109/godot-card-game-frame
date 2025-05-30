extends Button
@export var site:String


func _on_button_down() -> void:
	for d in get_tree().get_nodes_in_group("saveableDecks"):
		d.storCard()	
	get_tree().change_scene_to_file(site)
	pass # Replace with function body.
