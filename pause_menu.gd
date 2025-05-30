extends CanvasLayer


func show_menu():
	get_tree().paused = true
	visible = true
	load_save_list()
	pass
	
	
func hide_menu():
	get_tree().paused = false
	visible=false
	_on_save_back_button_down()
	pass
	
func _on_saves_button_down() -> void:
	$savePanel.visible=true
	var t = create_tween()
	await t.tween_property($savePanel,"size",Vector2(500,700),0.2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT).finished

	
func _on_save_back_button_down() -> void:
	var t = create_tween()
	await t.tween_property($savePanel,"size",Vector2(500,1),0.2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT).finished
	$savePanel.visible=false
	
func _on_quick_save_button_down() -> void:
	Infos.savePlayerInfo("autoSave")
	load_save_list()
	pass # Replace with function body.
	
func _on_back_button_down() -> void:
	hide_menu()
	pass # Replace with function body.

func load_save_list():
	var cs = $savePanel/ScrollContainer/VBoxContainer.get_children()
	for c in cs:
		c.queue_free()
		
	var dir = DirAccess.open("user://save/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name !="" :
			var save = load("user://save/"+file_name)
			var saveLine = load("res://save.tscn").instantiate()
			saveLine.saveData = save
			saveLine.saveName = file_name
			$savePanel/ScrollContainer/VBoxContainer.add_child(saveLine)
			file_name = dir.get_next()
			
			
func _on_exit_game_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_save_new_button_down() -> void:
	var time = Time.get_time_dict_from_system()
	var saveName = ("%02d-%02d-%02d" % [time.hour, time.minute, time.second])
	Infos.savePlayerInfo(saveName)
	load_save_list()
