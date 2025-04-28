extends PanelContainer

@export var label: Label

func _ready():
	if ChecksFinder.is_os_mobile():
		label.text = ("Please connect to Archepilago using console window,\n"+
			"located in a tab at the top")
	ChecksFinder.status = ChecksFinder.CFStatus.CONNECTING
	if (Archipelago.status == Archipelago.APStatus.DISCONNECTED
			and Archipelago.output_console):
		Archipelago.output_console.add_line(ChecksFinder.user_reminder_to_connect)
	elif not ChecksFinder.is_os_mobile():
		Archipelago.open_console()
	go_to_game.call_deferred()

func go_to_game():
	if ChecksFinder.item_status == ChecksFinder.ItemStatus.RECEIVED_ITEMS:
		Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_PLAYING)
		ChecksFinder.music.start()
		var scene = load("res://checksfinder/Game Scene.tscn").instantiate()
		ChecksFinder.replace_scene(scene)
	else:
		ChecksFinder.item_status_updated.connect(go_to_game, CONNECT_ONE_SHOT)
