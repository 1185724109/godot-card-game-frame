extends card
class_name npcCard

func drawCard():
	pickButton=$Button
	$nameLabel.text=cardInfo["base_displayName"]
	
	
func _on_button_down() -> void:
	if cardCurrentState ==cardState.hanging:
		return
	NpcManager.currentNpc=self
	cardCurrentState=cardState.hanging
	z_index=1000
	self.get_parent().move_child(self, -1)
	

		
	var tween1=create_tween()
	tween1.tween_property($TextureRect,"size",Vector2(1545,317),0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	var tween2=create_tween()
	tween2.tween_property($TextureRect/siteImg,"modulate",Color(1,1,1,1),0.5)
	var tween3=create_tween()
	tween3.tween_property(self,"global_position",get_parent().global_position,0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	$Button.visible=false
	$nameLabel.visible=true
	var dio = DialogueManager.show_dialogue_balloon_scene("res://assets/npcBalloon.tscn",load("res://dialogue/dialogue.dialogue"))
	dio.npc = self
	
func _on_esc() -> void:
	follow_target.visible=true
	cardCurrentState=cardState.following
	var tween1=create_tween()
	tween1.tween_property($TextureRect,"size",Vector2(220,317),0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	var tween2=create_tween()
	tween2.tween_property($TextureRect/siteImg,"modulate",Color(0.9,0.9,0.9,0.863),0.3)
	$Button.visible=true
	$nameLabel.visible=false
	
	
	
