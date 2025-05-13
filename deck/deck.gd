extends Panel


@onready var cardDeck: Control = $cardDcek
@onready var cardPoiDeck: HBoxContainer = $ScrollContainer/cardPoiDeck


func _process(delta: float) -> void:
	if cardDeck.get_child_count()!=0:
		var children = cardDeck.get_children()
		sort_nodes_by_position(children)
		
func sort_nodes_by_position(children):
	children.sort_custom(sort_by_position)
	for i in range(children.size()):
		if children[i].cardCurrentState:
			children[i].z_index = i
			cardDeck.move_child(children[i],i)

func sort_by_position(a, b):
	return a.position.x < b.position.x
	
func add_card(cardToAdd)->void:
	var index=cardToAdd.z_index
	var cardBackground=preload("res://card_background.tscn").instantiate()
	cardPoiDeck.add_child(cardBackground)
	
	
	if index<=cardPoiDeck.get_child_count():
		cardPoiDeck.move_child(cardBackground,index)
	else:
		cardPoiDeck.move_child(cardBackground,-1)
	var global_poi = cardToAdd.global_position  # 获取节点的全局位置
	
	if cardToAdd.get_parent():
		cardToAdd.get_parent().remove_child(cardToAdd)
	cardDeck.add_child(cardToAdd)
	cardToAdd.global_position=global_poi
	
	cardToAdd.follow_target=cardBackground
	
	cardToAdd.preDeck=self
	
	cardToAdd.cardCurrentState=cardToAdd.cardState.following
