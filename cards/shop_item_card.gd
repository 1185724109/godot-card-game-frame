extends card
class_name shopItemCard

var itemName
var priceRatio:float

signal showDia(diaName:String)
func drawCard():
	pickButton=$Button
	itemName=cardInfo["base_cardName"]
	
	$TextureRect/Panel/discription.text=cardInfo["base_description"]
	$TextureRect/VBoxContainer/ColorRect/name.text=cardInfo["base_displayName"]
	
	price = round(priceRatio*int(cardInfo["base_price"]))
	$price.text = str(price)
	
func _on_button_button_down() -> void:
	if Infos.save.money>=price:
		if Infos.add_new_card(itemName,Infos.hand_deck,self)!=null:
			Infos.save.money-=price
			Infos.playerUpdate()
	else:
		emit_signal("showDia","lackOfMoney")
		NpcManager.customCounter+=1
