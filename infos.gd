extends CanvasLayer

func add_new_card(cardName,cardDeck,caller = get_tree().get_first_node_in_group("cardDeck"))->Node:
	
	
		print("开始创建新卡牌："+str(cardName))
		var cardClass=CardInfos.infosDic[cardName]["base_cardClass"]
		print("添加的卡的类型为%s:"%cardClass)
		var cardToAdd
		
		cardToAdd=preload("res://cards/card.tscn").instantiate() as card
		
		cardToAdd.initCard(cardName)
		
		cardToAdd.global_position=caller.global_position
		cardToAdd.z_index=100
		cardDeck.add_card(cardToAdd)
		return cardToAdd
