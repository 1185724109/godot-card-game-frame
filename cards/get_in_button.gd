extends Button


func _on_mouse_entered() -> void:
	$Panel.visible=true
	var tween=create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	var tween=create_tween()
	await  tween.tween_property(self,"modulate",Color(1,1,1,0),0.2).finished
	pass # Replace with function body.
