class_name GameScene extends PanelContainer

enum SoundType{
	DIG, EXPLOSION, VICTORY
}

func _on_exit_pressed() -> void:
	$DigSound.finished.connect(func():
		Archipelago.ap_disconnect()
		ChecksFinder.music.stop_gradually()
		get_tree().change_scene_to_file("res://checksfinder/Start Menu.tscn"), CONNECT_ONE_SHOT)
	$DigSound.play()

func _on_game_cell_pressed(sound_type: SoundType) -> void:
	match sound_type:
		SoundType.DIG:
			$DigSound.play()
