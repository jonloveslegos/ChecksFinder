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
@export var force_mobile: bool = false

var all_items_dict: Dictionary[String, int] = build_items_dict([], 0)
var current_items_dict: Dictionary[String, int] = build_items_dict([], 0)
var current_items_dict_backup: Dictionary[String, int] = current_items_dict
var location_list: Array[int]
var cur_location_index: int:
	get:
		return min(theoretical_loc_index, max_in_logic_location_index())
var theoretical_loc_index: int = -1:
	set(val):
		theoretical_loc_index = min(val, location_list.size())
var location_waiting_on: int = 0
var has_used_ui_buttons: bool = false
var music: MusicController:
	get:
		return get_node("MusicController")

func _ready():
	randomize()
	var root = get_tree().root
	root.disable_3d = true
	root.set_min_size(Vector2i(600, 600))
	root.gui_embed_subwindows = is_os_mobile()
	if is_os_mobile():
		get_tree().change_scene_to_file.call_deferred("res://checksfinder/ChecksFinderClient.tscn")
	else:
		replace_scene(load("res://checksfinder/Start Menu.tscn").instantiate())
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

func send_location(min_index, max_index):
	if min_index >= 0 and min_index <= location_list.size():
		var index = min_index
		if max_index >= min_index and max_index <= location_list.size():
			for i in range(min_index, max_index + 1):
				if i == location_list.size() or not Archipelago.conn.slot_locations[location_list[index]]:
					index = i
		if index == location_list.size():
			return
		Archipelago.conn.scout(location_list[index], 0, func(item: NetworkItem):
			if item.dest_player_id == Archipelago.conn.player_id:
				item_status = ItemStatus.WAITING_FOR_CURRENT_ITEM
				location_waiting_on = location_list[index])
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

func get_cur_item_count() -> int:
	return get_cur_height() + get_cur_width() + get_cur_bombs() - 15

func get_count_in_logic() -> int:
	var count = 0
	if not Archipelago.conn:
		return 0
	for i in range(cur_location_index, min(get_all_item_count() + 5, location_list.size())):
		if not Archipelago.conn.slot_locations[location_list[i]]:
			count += 1
	return count

func get_completed_count() -> int:
	return Archipelago.conn.slot_locations.values().count(true)

func max_in_logic_location_index(cur_item_count = get_all_item_count()) -> int:
	return max(cur_item_count + 5 - 1, location_list.size())

func get_all_height() -> int:
	return min(all_items_dict["Map Height"] + 5, 10)

func get_all_width() -> int:
	return min(all_items_dict["Map Width"] + 5, 10)

func get_all_bombs() -> int:
	return min(all_items_dict["Map Bombs"] + 5, 20)

func get_all_item_count() -> int:
	return get_all_height() + get_all_width() + get_all_bombs() - 15

func _get_cur_location_index() -> int:
	if not location_list or Archipelago.conn.slot_locations.size() < location_list.size():
		return -1
	else:
		var index = 0
		for id in location_list:
			if not Archipelago.conn.slot_locations[id]:
				return index
			index += 1
		return index

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
	if item_status == ItemStatus.WAITING_FOR_CURRENT_ITEM:
		if items.any(func(item: NetworkItem):
				return item.loc_id == location_waiting_on):
			needed_item_received.emit()
			item_status = ItemStatus.RECEIVED_ITEMS
	else:
		item_status = ItemStatus.RECEIVED_ITEMS
	update_item_info.emit()

func _on_obtained_items(items: Array[NetworkItem]) -> void:
	var old_item_count = get_all_item_count()
	var dict = build_items_dict(items, -1)
	for key in all_items_dict.keys():
		all_items_dict[key] += dict[key]
	dict = build_items_dict(Archipelago.conn.received_items, cur_location_index + 1)
	for key in current_items_dict.keys():
		current_items_dict[key] += dict[key]
	theoretical_loc_index = _get_cur_location_index()
	if item_status == ItemStatus.WAITING_FOR_CURRENT_ITEM:
		if items.any(func(item: NetworkItem):
				return item.loc_id == location_waiting_on):
			needed_item_received.emit()
			item_status = ItemStatus.RECEIVED_ITEMS
	if old_item_count != get_all_item_count() and item_status != ItemStatus.WAITING_FOR_CURRENT_ITEM:
		item_status = ItemStatus.RECEIVED_ITEMS
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
	if event.is_action_pressed("console_toggle") and not is_os_mobile():
		if Archipelago.output_console:
			Archipelago.close_console()
		else:
			Archipelago.open_console()

func is_event_ui(event: InputEvent) -> bool:
	var _bool = (event.is_action_pressed("ui_down") or event.is_action_pressed("ui_left") or 
			event.is_action_pressed("ui_right") or event.is_action_pressed("ui_up") or 
			event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select") or
			event.is_action_pressed("ui_focus_next") or event.is_action_pressed("ui_focus_prev"))
	return _bool

func act_on_neighbour_cells(cell: GameCell, action: Callable):
	return cell.button_cell.act_on_neighbour_cells(action)

func is_os_mobile() -> bool:
	return force_mobile or OS.get_name() in ["Android", "iOS", "Web"]

func replace_scene(scene: Node):
	var tree = get_tree()
	if is_instance_valid(tree):
		var location
		if not is_os_mobile():
			location = tree.current_scene
		else:
			var client = tree.current_scene as ChecksFinderClient
			location = client.checksfinder_tab
		location.add_child(scene)
		var arr = location.get_children()
		for i in range(arr.size() - 1):
			arr[i].free.call_deferred()

func load_game_scene():
	var scene = load("res://checksfinder/Game Scene H.tscn").instantiate()
	ChecksFinder.replace_scene(scene)
