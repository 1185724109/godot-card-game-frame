extends Node2D


@export var scene_1:Node
@export var scene_2:Node
@export var scene_3:Node


@export var maxRandomItemNum:int
@export var minRandomItemNum:int
@export var siteItems:Dictionary


	
	
	
#写一个随机生成几张卡片的函数，首先从给定的随机最大值和最小值之间生成卡牌数量，然后根据卡牌数量从可选择的卡牌中根据卡牌出现概率选择生成的卡牌并执行生成函数，可选择的卡牌以字典的形式储存，键名为卡牌名，键值为出现概率，概率为0到100
func get_some_card():
	
	var num_cards = randi() % (maxRandomItemNum - minRandomItemNum + 1) + minRandomItemNum
	var total_weight = get_total_weight(siteItems)
	var selected_cards = []
	
	for i in range(num_cards):
		var random_num = randi() % total_weight
		var cumulative_weight = 0
		for c in siteItems.keys():
			cumulative_weight += siteItems[c]
			if random_num < cumulative_weight:
				selected_cards.append(c)
				break

	for c in selected_cards:
		var randomDeck = get_tree().get_nodes_in_group("cardDeck")[randi_range(0,1)]
		await get_tree().create_timer(0.1).timeout
		Infos.add_new_card(c,randomDeck,$Button)
	
	
# 计算权重总和
func get_total_weight(card_dict):
	var total_weight = 0
	for weight in card_dict.values():
		total_weight += weight
	return total_weight
