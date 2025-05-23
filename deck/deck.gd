extends Panel

class_name deck

@onready var cardDeck: Control = $cardDcek
@onready var cardPoiDeck: HBoxContainer = $ScrollContainer/cardPoiDeck

var currentWeight = 0
@export var maxWeight = 100
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
	
	if currentWeight+cardToAdd.cardWeight<=maxWeight:
		if card_is_stacked(cardToAdd):
			return
	
	
	
	
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
	update_weight()

func update_weight() -> void:
	var nowWeight=0
	for i in cardDeck.get_children():
		if i.cardCurrentState==i.cardState.following:
			nowWeight+=i.cardWeight*i.num
	currentWeight=nowWeight
	var weightText = str(currentWeight)+"/"+str(maxWeight)
	$weight.text = weightText
	$ProgressBar.value = currentWeight
	print(str(self.name)+"现在重量为"+weightText)


func card_is_stacked(cardToStack)->bool:
	for i in cardDeck.get_children():
		if cardToStack.cardName==i.cardName && i.cardCurrentState==i.cardState.following:
			if i.cardStack(cardToStack):
				fake_card_move(i)
				cardToStack.queue_free()
				update_weight()
				return true
	return false
	
	
func fake_card_move(cardTofake):
	var fakeCard=cardTofake.duplicate()
	#fakeCard.initCard(cardTofake.cardName)
	fakeCard.z_index=1000
	fakeCard.cardCurrentState=fakeCard.cardState.fake
	VfSlayer.add_child(fakeCard)
	fakeCard.global_position=get_global_mouse_position()-Vector2(125,180)
	var tween=create_tween()
	await  tween.tween_property(fakeCard,"global_position",cardTofake.global_position,0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).finished
	fakeCard.queue_free()
	
	
	
	
