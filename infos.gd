extends CanvasLayer


#存储所有的存档
var saves:Dictionary

var save:player

var playerInfoPath:String

@onready var hand_deck: Control = $handDeck

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

func loadPlayerInfo(savePath:String="autoSave"):
	var path = "user://save/"+savePath+".tres"
	playerInfoPath=path
	save = load(playerInfoPath) as player
	hand_deck.maxWeight=save.handMax
	get_tree().change_scene_to_file(save.location)
	hand_deck.loadCards()
	visible = true

func savePlayerInfo(newSavePath:String):
	for d in get_tree().get_nodes_in_group("saveableDecks"):
		d.storCard()
	var path = save.folderPath+newSavePath+".tres"
	ResourceSaver.save(save,path)
	print("存档保存至"+path)
