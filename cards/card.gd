extends Control
class_name card

var velocity = Vector2.ZERO
var damping = 0.35
var stiffness = 500

var preDeck

@export var cardClass:String
@export var cardName:String
@export var maxStackNum:int
@export var cardWeight:float
@export var cardInfo:Dictionary

var pickButton

enum cardState{following,dragging}
@export var cardCurrentState=cardState.following

@export var follow_target:Node
var whichDeckMouseIn


func _process(delta: float) -> void:
	match  cardCurrentState:
		cardState.dragging:
			var target_position=get_global_mouse_position()-size/2
			global_position=global_position.lerp(target_position, 0.4)
			
			var mouse_position = get_global_mouse_position()
			var nodes = get_tree().get_nodes_in_group("cardDropable")
			for node in nodes:
				if node.get_global_rect().has_point(mouse_position)&&node.visible==true:
					whichDeckMouseIn=node
			
		cardState.following:
			if follow_target!=null:
				var target_position=follow_target.global_position
				var displacement = target_position - global_position
				var force = displacement * stiffness
				velocity += force * delta
				velocity *= (1.0 - damping)
				global_position += velocity * delta




func _on_button_button_down() -> void:
	cardCurrentState = cardState.dragging
	if follow_target!=null:
		follow_target.queue_free()	
	pass # Replace with function body.


func _on_button_button_up() -> void:
	cardCurrentState = cardState.following
	if whichDeckMouseIn!=null:
		whichDeckMouseIn.add_card(self)
	else:
		preDeck.add_card(self)
	pass # Replace with function body.

func initCard(Nm) -> void:
	cardInfo=CardInfos.infosDic[Nm]
	cardWeight=float(cardInfo["base_cardWeight"])
	cardClass=cardInfo["base_cardClass"]
	cardName=cardInfo["base_cardName"]
	maxStackNum=int(cardInfo["base_maxStack"])
	cardCurrentState=cardState.following
	drawCard()


func drawCard():
	
	#print(cardInfo)
	pickButton=$Button
	var imgPath="res://cardImg/"+str(cardName)+".png"
	$Control/ColorRect/itemImg.texture=load(imgPath)
	$Control/ColorRect/name.text=cardInfo[ "base_displayName"]
