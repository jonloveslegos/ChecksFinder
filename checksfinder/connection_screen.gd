extends PanelContainer

func _ready():
	ChecksFinder.status = ChecksFinder.CFStatus.CONNECTING
	if (Archipelago.status == Archipelago.APStatus.DISCONNECTED
			and Archipelago.output_console):
		Archipelago.output_console.add_line(ChecksFinder.user_reminder_to_connect)
	else:
		Archipelago.open_console()
	go_to_game.call_deferred()

func go_to_game():
	if ChecksFinder.item_status == ChecksFinder.ItemStatus.RECEIVED_ITEMS:
		Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_PLAYING)
		ChecksFinder.music.start()
		get_tree().change_scene_to_file("res://checksfinder/Game Scene.tscn")
	else:
		ChecksFinder.item_status_updated.connect(go_to_game, CONNECT_ONE_SHOT)
