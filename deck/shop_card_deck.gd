extends  "res://deck/deck.gd"
var priceRatio:float
signal showDia(diaName:String)


func add_card(cardToAdd:Node)->void:
	var price = cardToAdd.price
	if price<=0:
			emit_signal("showDia","worthless")
			return
	Infos.save.money+=cardToAdd.price*cardToAdd.num
	Infos.playerUpdate()
	cardToAdd.queue_free()
	emit_signal("showDia","deal")

func clear_deck():
	for i in $cardDcek.get_children():
		i.queue_free()
	for i in $ScrollContainer/cardPoiDeck.get_children():
		i.queue_free()
