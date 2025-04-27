class_name StartMenu extends PanelContainer

@export var starting_focus: ButtonWrapper

func _ready():
	ChecksFinder.status = ChecksFinder.CFStatus.START_MENU
	starting_focus.inner_grab_focus()

func _on_play_online_pressed():
	$ClickSound.finished.connect(func():
		get_tree().change_scene_to_file("res://checksfinder/Connection Scene.tscn"),
		CONNECT_ONE_SHOT)
	$ClickSound.play()
	
func _on_play_offline_pressed():
	$ClickSound.play()

func _gui_input(event: InputEvent) -> void:
	if ChecksFinder.is_event_ui(event):
		ChecksFinder.has_used_ui_buttons = true
