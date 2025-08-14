extends Node

var currentNpc:Control


func npc_give_card(cardName,num:int=1):
	for i in range(num):
		await get_tree().create_timer(0.1).timeout
		await Infos.add_new_card(cardName,Infos.hand_deck,Infos.hand_deck)
		
		
func esc_dialouge():
	currentNpc._on_esc()
