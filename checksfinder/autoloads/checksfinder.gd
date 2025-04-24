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

var items_dict: Dictionary[String, int] = build_items_dict([])
var has_used_ui_buttons: bool = false
var music: MusicController:
	get:
		return get_node("MusicController")

func _ready():
	randomize()
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
	

func build_items_dict(items: Array[NetworkItem]) -> Dictionary[String, int]:
	var dict: Dictionary[String, int] = {
		"Map Bombs": 0,
		"Map Width": 0,
		"Map Height": 0
	}
	if items.size() > 0:
		var data: DataCache = Archipelago.conn.get_gamedata_for_player(Archipelago.conn.player_id)
		for n_item in items:
			var item = data.get_item_name(n_item.id)
			if item in dict.keys():
				dict[item] += 1
	return dict

func get_height():
	return items_dict["Map Height"] + 5

func get_width():
	return items_dict["Map Width"] + 5

func get_bombs():
	return items_dict["Map Bombs"] + 5

func _on_refresh_items(items: Array[NetworkItem]) -> void:
	var dict = build_items_dict(items)
	if items_dict != dict:
		items_dict = dict

func _on_obtained_items(items: Array[NetworkItem]) -> void:
	var dict = build_items_dict(items)
	for key in dict.keys():
		items_dict[key] += dict[key]

func _shortcut_input(event):
	if event.is_action_pressed("console_toggle"):
		if Archipelago.output_console:
			Archipelago.close_console()
		else:
			Archipelago.open_console()

func is_event_ui(event: InputEvent) -> bool:
	return (event.is_action_pressed("ui_down") or event.is_action_pressed("ui_left") or 
			event.is_action_pressed("ui_right") or event.is_action_pressed("ui_up") or 
			event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select") or
			event.is_action_pressed("ui_focus_next") or event.is_action_pressed("ui_focus_prev"))

func act_on_neighbour_cells(cell: GameCell, action: Callable):
	cell.button_cell.act_on_neighbour_cells(action)
