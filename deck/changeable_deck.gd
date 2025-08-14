extends "res://deck/deck.gd"
var compressed=false
var compressedSize=Vector2(130,360)
var normalSize=Vector2(240,360)

func _on_get_all_button_down() -> void:
	var cards=cardDeck.get_children()
	for i in cards:
		i._on_all_button_button_down()
	pass # Replace with function body.

func _on_compressed_toggled(toggled_on: bool) -> void:
	compressed=toggled_on
	var cardPois=cardPoiDeck.get_children()
	if compressed:
		for i in cardPois:
			i.custom_minimum_size=compressedSize
	else :
		for i in cardPois:
			i.custom_minimum_size=normalSize
	pass # Replace with function body.


func _on_card_poi_deck_child_entered_tree(node: Node) -> void:
	if compressed:
		node.custom_minimum_size=compressedSize
	pass # Replace with function body.


func _on_delete_mouse_entered() -> void:
	for i in cardDeck.get_children():
		if i.cardCurrentState==i.cardState.dragging:
			i.del = true
	pass # Replace with function body.



func _on_delete_mouse_exited() -> void:
	for i in cardDeck.get_children():
		if i.cardCurrentState==i.cardState.dragging:
			i.del = false


func _on_get_all_button_up() -> void:
	var cards=cardDeck.get_children()
	for i in cards:
		i._on_button_button_up()
	pass # Replace with function body.
