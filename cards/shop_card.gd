extends card
class_name shopCard
var priceRatio
@export var items:PackedStringArray
var diaPath:String="res://dialogue/shop.dialogue"

func drawCard():
	pickButton=$Button
	$nameLabel.text=cardInfo["base_displayName"]
	$Button/Panel/Label.text=cardInfo["base_description"]
	priceRatio = cardInfo["base_cardWeight"]
	items = cardInfo["base_price"].split("!")
	%shopCardDeck.connect("showDia",show_dia)
	
	
var deckP
func _on_button_down() -> void:
	
	NpcManager.currentNpc=self
	$Button.visible=false
	cardCurrentState=cardState.hanging
	
	deckP = get_parent()
	var poi = global_position
	get_parent().remove_child(self)
	VfSlayer.add_child(self)
	global_position = poi
	
	follow_target.visible=false
	var tween1=create_tween()
	tween1.tween_property($TextureRect,"size",Vector2(1545,317),0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

	$Button2.visible=true
	$nameLabel.visible=true
	var tween5=create_tween()
	tween5.tween_property($TextureRect/npcImg,"modulate",Color(1,1,1,1),0.5)
	var tween3=create_tween()
	await tween3.tween_property(self,"global_position",Vector2(355,0),0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished

	$shopCardDeck.visible=true
	var tween4=create_tween()
	await tween4.tween_property($shopCardDeck,"size",Vector2(1565,360),0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished
	get_tree().get_first_node_in_group("midDeck").visible = false
	dioScene = DialogueManager.show_dialogue_balloon_scene("res://assets/shopBalloon.tscn",load(diaPath))
	
	shop_add_card()
	
	pass
	
var dioScene:Node
func show_dia(diaName:String):
	if dioScene!=null:
		dioScene.queue_free()
	dioScene=DialogueManager.show_dialogue_balloon_scene("res://assets/shopBalloon.tscn",load(diaPath),diaName)
func shop_add_card():
	for i in items:
		var cardToAdd=preload("res://cards/shopItemCard.tscn").instantiate() as shopItemCard
		cardToAdd.priceRatio = float(priceRatio)
		cardToAdd.connect("showDia",show_dia)
		cardToAdd.initCard(i)
		cardToAdd.global_position=$shopCardDeck.global_position+Vector2($shopCardDeck.size.x,0)
		
		
		#自定义的牌桌添加部分
		var cardBackground=preload("res://card_background.tscn").instantiate()
		$shopCardDeck.cardPoiDeck.add_child(cardBackground)
		var global_poi = cardToAdd.global_position  # 获取节点的全局位置
		if cardToAdd.get_parent():
			cardToAdd.get_parent().remove_child(cardToAdd)
		$shopCardDeck.cardDeck.add_child(cardToAdd)
		cardToAdd.global_position=global_poi
		
		cardToAdd.follow_target=cardBackground
		cardToAdd.cardCurrentState=cardToAdd.cardState.following
		
		await get_tree().create_timer(0.1).timeout
func leave():
	await get_tree().create_timer(0.5).timeout
	var t= create_tween()
	t.tween_property(self,"modulate",Color(1,1,1,0),0.3)
	visible = false
	follow_target.visible = false
	
func _on_esc() -> void:
	var poi = global_position
	VfSlayer.remove_child(self)
	deckP.add_child(self)
	global_position = poi

	$shopCardDeck.clear_deck()
	
	if dioScene!=null:
		dioScene.queue_free()
		dioScene=null
	get_tree().get_first_node_in_group("midDeck").visible = true
	var tween3=create_tween()
	await  tween3.tween_property($shopCardDeck,"size",Vector2(1565,1),0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished

	cardCurrentState=cardState.following
	$Button2.visible=false
	follow_target.visible=true
	
	var tween5=create_tween()
	tween5.tween_property($TextureRect/npcImg,"modulate",Color(1,1,1,0),0.2)
	
	var tween1=create_tween()
	tween1.tween_property($TextureRect,"size",Vector2(220,317),0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	$shopCardDeck.visible=false
	$Button.visible=true
	$nameLabel.visible=false
	
	
	
