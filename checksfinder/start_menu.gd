class_name StartMenu extends PanelContainer

@export var starting_focus: ButtonWrapper
@export var version_label: Label

func _ready():
	ChecksFinder.status = ChecksFinder.CFStatus.START_MENU
	starting_focus.inner_grab_focus()
	version_label.text = "v%s.%s.%s" % [Archipelago.AP_CLIENT_VERSION.major,
		Archipelago.AP_CLIENT_VERSION.minor,
		Archipelago.AP_CLIENT_VERSION.build]

func _input(event: InputEvent) -> void:
	if ChecksFinder.is_event_ui(event):
		ChecksFinder.has_used_ui_buttons = true

func _on_settings_pressed() -> void:
	$ClickSound.finished.connect(func():
		var scene = load("res://checksfinder/Settings.tscn").instantiate()
		ChecksFinder.replace_scene(scene),
		CONNECT_ONE_SHOT)
	$ClickSound.play()

func _on_play_online_pressed():
	$ClickSound.finished.connect(func():
		var scene = load("res://checksfinder/Connection Scene.tscn").instantiate()
		ChecksFinder.replace_scene(scene),
		CONNECT_ONE_SHOT)
	$ClickSound.play()
	
func _on_play_offline_pressed():
	$ClickSound.play()
