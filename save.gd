extends Panel
var saveData:player
var saveName:String
var pureName:String
func _ready() -> void:
	var saveInfo =saveData.playerName
	pureName = saveName.split(".")[0]
	$VBoxContainer/saveName.text = pureName
	$VBoxContainer/saveInfos.text = saveInfo

func _on_button_button_down() -> void:
	Infos.loadPlayerInfo(pureName)
	PauseMenu.hide_menu()
	pass # Replace with function body.

func _on_delete_button_button_down() -> void:
	var file_path:String = "user://save/"+saveName
# 创建 DirAccess 实例
	var dir_access = DirAccess.open(file_path.get_base_dir())
	if dir_access and dir_access.file_exists(file_path):
		if dir_access.remove(file_path) == OK:
			print("文件已成功删除：%s" % file_path)
			queue_free()
		else:
			print("无法删除文件：%s" % file_path)
	else:
		print("目录或文件不存在：%s" % file_path)
