extends Node


enum CFStatus{
	START_MENU,
	CONNECTING,
	PLAYING
}
	
var status: CFStatus = CFStatus.START_MENU
@export var user_reminder_to_connect: String = (
		"Please write archipelago connection data into the slider box on the right"
	)

func _ready():
	var root = get_tree().root
	root.set_min_size(Vector2i(400, 300))
	root.disable_3d = true
	root.gui_embed_subwindows = false
	Archipelago.on_attach_console.connect(func():
		if (Archipelago.status == Archipelago.APStatus.DISCONNECTED
				and ChecksFinder.status != ChecksFinder.CFStatus.START_MENU):
			Archipelago.output_console.add_line(
					user_reminder_to_connect
				)
			)

func _shortcut_input(event):
	if event.is_action_pressed("console_toggle"):
		if Archipelago.output_console != null:
			Archipelago.close_console()
		else:
			Archipelago.open_console()
