extends PanelContainer

@export var label: Label

func _ready():
	if ChecksFinder.is_os_mobile():
		label.text = ("Please connect to Archipelago using console window, "+
			"located in a tab at the top")
	ChecksFinder.status = ChecksFinder.CFStatus.CONNECTING
	if (Archipelago.status == Archipelago.APStatus.DISCONNECTED
			and Archipelago.output_console):
		Archipelago.output_console.add_line(ChecksFinder.user_reminder_to_connect)
	elif not ChecksFinder.is_os_mobile():
		Archipelago.open_console()
	go_to_game.call_deferred()

func _draw():
	if size.x >= 800:
		label.custom_minimum_size = Vector2(750.0, 0.0)
	elif 750.0 <= size.x and size.x < 800.0:
		label.custom_minimum_size = Vector2(700.0, 0.0)
	elif 700.0 <= size.x and size.x < 750.0:
		label.custom_minimum_size = Vector2(650.0, 0.0)
	elif 650.0 <= size.x and size.x < 700.0:
		label.custom_minimum_size = Vector2(600.0, 0.0)
	elif size.x < 650.0:
		label.custom_minimum_size = Vector2(550.0, 0.0)

func go_to_game():
	if ChecksFinder.item_status == ChecksFinder.ItemStatus.RECEIVED_ITEMS:
		Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_PLAYING)
		ChecksFinder.music.start()
		ChecksFinder.load_game_scene()
	else:
		ChecksFinder.item_status_updated.connect(go_to_game, CONNECT_ONE_SHOT)
