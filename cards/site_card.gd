extends card
class_name siteCard


func drawCard():
	#设置另外的可拾取按钮
	pickButton=$getInButton
	
	$getInButton/Panel/Label.text=cardInfo["base_description"]
	$TextureRect/VBoxContainer/siteName.text=cardInfo["base_displayName"]
	
	$getInButton.visible=true

func _on_get_in_button_button_down() -> void:
	var path ="res://site/"+cardName+".tscn"
	for d in get_tree().get_nodes_in_group("saveableDecks"):
		d.storCard()	
	get_tree().change_scene_to_file(path)
	pass # Replace with function body.
