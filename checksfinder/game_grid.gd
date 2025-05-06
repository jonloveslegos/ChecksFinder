class_name GameGrid extends GridContainer

enum GameState{
	EMPTY, GENERATING, PLAYING, LOST, VICTORY
}
var game_state = GameState.EMPTY

var children: Array[GameCell] = []
var has_loss_animation_finished: bool = false
var hovered_cell: GameCell = null
var has_long_tapped: bool = false
@onready var height = ChecksFinder.get_cur_height()
@onready var width = ChecksFinder.get_cur_width()
@onready var bombs = ChecksFinder.get_cur_bombs()
@onready var saved_item_count = ChecksFinder.get_cur_item_count()
@warning_ignore("integer_division")
@onready var mine_count = min(bombs, width*height/5)
@onready var current_location_index = ChecksFinder.cur_location_index
@export var recursive_delay: float = 0.09
@export var end_screen_delay_win: float = 0.9
@export var end_screen_delay_loss: float = 0.9
@export var game_scene: GameScene
@export var timer: Timer
signal game_grid_sound(sound)
signal updated_marked_mines(count: int)
var marked_count = 0:
	set(val):
		if val != marked_count:
			marked_count = val
			updated_marked_mines.emit(marked_count)

func _ready() -> void:
	columns = width
	for i in range(width * height):
		var cell = load("res://checksfinder/Game Cell.tscn").instantiate() as GameCell
		add_child(cell)
		cell.index = i
		children.append(cell)
		cell.name = "Game Cell %d" % [cell.index]
		cell.pressed_sound.connect(game_scene._on_game_cell_pressed_sound)
		cell.revealed_cell.connect(_on_game_cell_revealed)
		cell.game_grid = self
		cell.draw.connect(func():
			if height > 16:
				var font_size = 50
				var font_size_diff = 2
				var height_inc = 17
				cell.label.position.y += 1.0
				while height_inc <= height:
					font_size -= font_size_diff
					if height_inc > 19:
						font_size_diff -= 1
						font_size_diff = max(font_size_diff, 0)
					else:
						font_size_diff += 1
					height_inc += 1
				if height > 18:
					cell.label.position.y += 1.0
				if height > 20:
					cell.label.position.y += 1.0
					cell.label.position.x -= 1.0
				cell.label.add_theme_font_size_override("font_size", font_size),
				CONNECT_ONE_SHOT
		)

func _input(event: InputEvent) -> void:
	var focus_owner = get_viewport().gui_get_focus_owner()
	if ChecksFinder.is_event_ui(event) or event.is_action("flag_keyboard"):
		if not focus_owner:
			children[0].button_cell.grab_focus()
		ChecksFinder.has_used_ui_buttons = true
	if focus_owner is CellButton:
		if event is InputEventMouseButton:
			focus_owner.release_focus()
	if event is InputEventScreenTouch and event.index == 0:
		if event.is_pressed() and not has_long_tapped and timer.is_stopped():
			timer.start()
		else:
			has_long_tapped = false
			timer.stop()

func _on_timer_timeout() -> void:
	has_long_tapped = true
	hovered_cell.action_flag()

func _on_game_cell_revealed(game_cell: GameCell) -> void:
	if game_state == GameState.EMPTY:
		game_state = GameState.GENERATING
		#generate board
		game_cell.contents = GameCell.CellContents.NUMBER
		game_cell.act_on_neighbour_cells(func(cell: CellButton):
			cell.root_game_cell.contents = GameCell.CellContents.NUMBER
			return true)
		for _i in range(mine_count):
			while true:
				var x = randi_range(0, width-1)
				var y = randi_range(0, height-1)
				var rnd_cell = children[y*width + x]
				if rnd_cell.contents == GameCell.CellContents.UNSET:
					rnd_cell.contents = GameCell.CellContents.BOMB
					break
		for cell in children:
			if cell.contents == GameCell.CellContents.UNSET:
				cell.contents = GameCell.CellContents.NUMBER
			if cell.contents == GameCell.CellContents.NUMBER:
				cell.nearby_bomb_count = cell.count_neighbouring_bombs()
		game_state = GameState.PLAYING
		game_cell.try_to_reveal(false)
	elif game_state == GameState.PLAYING:
		if game_cell.nearby_bomb_count == 0:
			await get_tree().create_timer(recursive_delay).timeout
			game_cell.button_cell.outer.hover_enabled = false
			var opened = game_cell.act_on_neighbour_cells(func(cell: CellButton):
				return cell.root_game_cell.try_to_reveal(true))
			if opened:
				game_grid_sound.emit(SoundType.DIG)
		elif game_cell.contents == GameCell.CellContents.BOMB:
			game_state = GameState.LOST
			game_cell.has_blown_up = true
			await get_tree().create_timer(recursive_delay).timeout
			game_grid_sound.emit(SoundType.EXPLOSION)
			loss(game_cell)
			return
		if children.all(func(cell: GameCell):
				return cell.contents == GameCell.CellContents.BOMB or cell.revealed):
			game_state = GameState.VICTORY
			await get_tree().create_timer(recursive_delay).timeout
			game_grid_sound.emit(SoundType.GENERIC_WIN)
			for cell in children:
				cell.marked = false
				cell.revealed = true
				cell.react_to_cell_state_change()
			await get_tree().create_timer(end_screen_delay_win).timeout
			ChecksFinder.send_location(current_location_index,
				ChecksFinder.max_in_logic_location_index(saved_item_count))
			if ChecksFinder.get_all_item_count() == 25:
				game_scene.VictoryScreen.visible = true
				ChecksFinder.music.victory()
				Archipelago.set_client_status(AP.ClientStatus.CLIENT_GOAL)
			if ChecksFinder.item_status == CF.ItemStatus.WAITING_FOR_CURRENT_ITEM:
				await ChecksFinder.needed_item_received
			if game_scene.generic_win_sound.playing:
				await game_scene.generic_win_sound.finished
			if not game_scene.VictoryScreen.visible:
				ChecksFinder.load_game_scene()
	elif game_state == GameState.LOST:
		await get_tree().process_frame
		loss(game_cell)

func loss(game_cell: GameCell) -> void:
	game_cell.act_on_neighbour_cells(func(cell: CellButton):
		if not cell.root_game_cell.has_blown_up:
			cell.root_game_cell.has_blown_up = true
			cell.root_game_cell.marked = false
			return cell.root_game_cell.try_to_reveal(true)
		return false)
	if not has_loss_animation_finished and children.all(func(cell: GameCell): return cell.revealed):
		has_loss_animation_finished = true
		await get_tree().create_timer(end_screen_delay_loss).timeout
		AP.log("ended delay")
		if game_scene.explosion_sound.playing:
			await game_scene.explosion_sound.finished
		ChecksFinder.load_game_scene()
