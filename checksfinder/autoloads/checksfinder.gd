class_name CF extends Node


enum CFStatus{
	START_MENU,
	CONNECTING,
	PLAYING
}
enum ItemStatus{
	NO_ITEMS,
	RECEIVED_ITEMS,
	WAITING_FOR_CURRENT_ITEM
}
signal cf_status_changed
signal item_status_updated
signal needed_item_received
signal update_item_info
signal changed_connection
var status: CFStatus = CFStatus.START_MENU:
	set(val):
		if status != val:
			status = val
			cf_status_changed.emit()
var item_status: ItemStatus = ItemStatus.NO_ITEMS:
	set(val):
		if item_status != val:
			item_status = val
		item_status_updated.emit()
@export var user_reminder_to_connect: String = (
		"Please write archipelago connection data into the slider box on the right"
	)

var all_items_dict: Dictionary[String, int] = build_items_dict([], 0)
var current_items_dict: Dictionary[String, int] = build_items_dict([], 0)
var current_items_dict_backup: Dictionary[String, int] = current_items_dict
var location_list: Array[int]
var cur_location_index: int:
	get:
		return min(theoretical_loc_index, get_all_item_count() + 5, 25)
var theoretical_loc_index: int = -1:
	set(val):
		theoretical_loc_index = min(val, location_list.size(), 25)
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
	Archipelago.connected.connect(_on_connected)
	Archipelago.remove_location.connect(_on_removed_location)
	Archipelago.disconnected.connect(_on_disconnected)

func _on_connected(conn: ConnectionInfo, _json: Dictionary):
	location_list = Archipelago.location_list()
	location_list.sort()
	theoretical_loc_index = _get_cur_location_index()
	conn.refresh_items.connect(_on_refresh_items)
	conn.obtained_items.connect(_on_obtained_items)
	conn.all_scout_cached.connect(_on_all_scout_cached)
	conn.force_scout_all()

func send_location(index):
	if index >= 0 and index < location_list.size():
		Archipelago.conn.scout(location_list[index], 0, func(item: NetworkItem):
			if item.dest_player_id == Archipelago.conn.player_id:
				item_status = ItemStatus.WAITING_FOR_CURRENT_ITEM)
		Archipelago.collect_location(location_list[index])

func build_items_dict(items: Array[NetworkItem], count: int) -> Dictionary[String, int]:
	var dict: Dictionary[String, int] = {
		"Map Bombs": 0,
		"Map Width": 0,
		"Map Height": 0
	}
	var size = items.size()
	if count < 0:
		count = size + count + 1
	if count > size:
		count = size
	if items.size() > 0:
		var data: DataCache = Archipelago.conn.get_gamedata_for_player(Archipelago.conn.player_id)
		for n_item in items:
			count -= 1
			if count < 0:
				break
			var item = data.get_item_name(n_item.id)
			if item in dict.keys():
				dict[item] += 1
	return dict

func get_cur_height() -> int:
	return min(current_items_dict["Map Height"] + 5, 10)

func get_cur_width() -> int:
	return min(current_items_dict["Map Width"] + 5, 10)

func get_cur_bombs() -> int:
	return min(current_items_dict["Map Bombs"] + 5, 20)

func get_count_in_logic() -> int:
	var count = 0
	for i in range(cur_location_index, min(get_all_item_count() + 5, 25)):
		if not Archipelago.conn.slot_locations[location_list[i]]:
			count += 1
	return count

func get_completed_count() -> int:
	return Archipelago.conn.slot_locations.values().count(true)

func get_all_item_count() -> int:
	return get_all_height() + get_all_width() + get_all_bombs() - 15

func get_all_height() -> int:
	return min(all_items_dict["Map Height"] + 5, 10)

func get_all_width() -> int:
	return min(all_items_dict["Map Width"] + 5, 10)

func get_all_bombs() -> int:
	return min(all_items_dict["Map Bombs"] + 5, 20)

func _get_cur_location_index() -> int:
	if not location_list or Archipelago.conn.slot_locations.size() < 25:
		return -1
	else:
		var index = 0
		for id in location_list:
			if not Archipelago.conn.slot_locations[id]:
				return index
			index += 1
	return location_list.size()

func _on_all_scout_cached() -> void:
	if item_status == ItemStatus.NO_ITEMS:
		item_status = ItemStatus.RECEIVED_ITEMS

func _on_refresh_items(items: Array[NetworkItem]) -> void:
	var dict = build_items_dict(items, -1)
	all_items_dict = dict
	dict = build_items_dict(items, cur_location_index + 1)
	current_items_dict = dict
	if current_items_dict_backup != current_items_dict:
		changed_connection.emit()
	item_status = ItemStatus.RECEIVED_ITEMS
	update_item_info.emit()

func _on_obtained_items(items: Array[NetworkItem]) -> void:
	var dict = build_items_dict(items, -1)
	var old_loc_index = cur_location_index
	for key in all_items_dict.keys():
		all_items_dict[key] += dict[key]
	theoretical_loc_index = _get_cur_location_index()
	if old_loc_index != cur_location_index:
		item_status = ItemStatus.RECEIVED_ITEMS
		needed_item_received.emit()
	update_item_info.emit()

func _on_removed_location(_loc_id: int) -> void:
	var index = _get_cur_location_index()
	if index >= 0:
		theoretical_loc_index = index
	var dict = build_items_dict(Archipelago.conn.received_items, cur_location_index + 1)
	current_items_dict = dict
	update_item_info.emit()

func _on_needed_item_received() -> void:
	var dict = build_items_dict(Archipelago.conn.received_items, cur_location_index + 1)
	current_items_dict = dict
	update_item_info.emit()

func _on_disconnected():
	current_items_dict_backup = current_items_dict

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
	return cell.button_cell.act_on_neighbour_cells(action)
