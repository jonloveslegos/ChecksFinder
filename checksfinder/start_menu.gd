class_name StartMenu extends PanelContainer

func _ready():
	ChecksFinder.status = ChecksFinder.CFStatus.START_MENU
	get_node(
		"VBoxContainer/CenterContainer2/PanelContainer/PanelContainer/PlayOnline"
		).grab_focus()

func _on_play_online_pressed():
	$ClickSound.finished.connect(func():
		get_tree().change_scene_to_file("res://checksfinder/Connection Scene.tscn"),
		CONNECT_ONE_SHOT)
	$ClickSound.play()
	
func _on_play_offline_pressed():
	$ClickSound.play()
