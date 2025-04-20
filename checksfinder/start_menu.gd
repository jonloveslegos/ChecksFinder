class_name StartMenu extends Control

func _ready():
	var viewport = get_viewport()
	viewport.disable_3d = true
	viewport.gui_embed_subwindows = false
	

func _shortcut_input(event):
	if event.is_action_pressed("console_toggle"):
		if Archipelago.output_console != null:
			Archipelago.close_console()
		else:
			Archipelago.open_console()
