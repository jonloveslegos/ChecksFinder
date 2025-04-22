extends PanelContainer


func _on_exit_pressed() -> void:
	$DigSound.finished.connect(func():
		Archipelago.ap_disconnect()
		get_tree().change_scene_to_file("res://checksfinder/Connection Scene.tscn"),
		CONNECT_ONE_SHOT)
	$DigSound.play()
	
