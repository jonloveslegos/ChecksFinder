class_name GameCell extends PanelContainer

@export var button_cell: CellButton
@export var panel: Panel
@export var label: Label
var game_grid: GameGrid

enum CellContents{
	UNSET, BOMB, NUMBER
}
var contents: CellContents = CellContents.UNSET
var revealed = false
var marked = false
signal revealed_cell(cell: GameCell)
signal pressed_sound(sound)
var nearby_bomb_count: int = -1
var has_blown_up: bool = false
var index: int = -1

func _ready():
	button_cell.root_game_cell = self
	button_cell.label = label

func _on_button_cell_pressed() -> void:
	if game_grid.game_state in [GameGrid.GameState.PLAYING, GameGrid.GameState.EMPTY]:
		if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or
			Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_select")
		):
			var _opened = try_to_reveal(false)
			if not _opened and revealed and contents == CellContents.NUMBER:
				if nearby_bomb_count == count_neighbouring_marks():
					var opened = act_on_neighbour_cells(func(cell: CellButton):
						return cell.root_game_cell.try_to_reveal(true))
					if opened:
						pressed_sound.emit(SoundType.DIG)
		elif ((Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) or 
			Input.is_action_just_pressed("flag")) and 
			game_grid.game_state == GameGrid.GameState.PLAYING
		):
			if not revealed and game_grid.game_state == game_grid.GameState.PLAYING:
				if marked:
					marked = false
					game_grid.marked_count -= 1
				else:
					marked = true
					game_grid.marked_count += 1
				react_to_cell_state_change()

func try_to_reveal(recursive: bool) -> bool:
	if not marked and (not revealed or game_grid.game_state == GameGrid.GameState.LOST):
		if game_grid.game_state == GameGrid.GameState.GENERATING:
			return false
		if not game_grid.game_state == GameGrid.GameState.EMPTY:
			revealed = true
			if not recursive:
				pressed_sound.emit(SoundType.DIG)
		if not game_grid.game_state == GameGrid.GameState.VICTORY:
			revealed_cell.emit(self)
		react_to_cell_state_change()
		return true
	return false

func react_to_cell_state_change() -> void:
	if not revealed:
		if marked:
			panel.theme = load("res://checksfinder/ui/themes/x_mark.tres") as Theme
			pressed_sound.emit(SoundType.DIG)
		else:
			panel.theme = load("res://checksfinder/ui/themes/empty.tres") as Theme
			pressed_sound.emit(SoundType.DIG)
	else:
		button_cell.inner_theme_normal = "res://checksfinder/ui/themes/darkbrownborder_bottomright.tres"
		button_cell.inner_theme_hover = "res://checksfinder/ui/themes/darkbrownborder_topleft.tres"
		button_cell.outer_theme_normal = "res://checksfinder/ui/themes/lightbrownborder_topleft.tres"
		button_cell.outer_theme_hover = "res://checksfinder/ui/themes/lightbrownborder_bottomright.tres"
		button_cell.inner.theme = load(button_cell.inner_theme_normal) as Theme
		button_cell.outer.theme = load(button_cell.outer_theme_normal) as Theme
		match contents:
			CellContents.BOMB:
				panel.theme = load("res://checksfinder/ui/themes/bomb.tres") as Theme
			CellContents.NUMBER:
				panel.theme = load("res://checksfinder/ui/themes/empty.tres") as Theme
				if nearby_bomb_count > 0:
					label.text = str(nearby_bomb_count)
				else:
					pass
					#button_cell.disabled = true
			CellContents.UNSET:
				panel.theme = load("res://checksfinder/ui/themes/x_mark.tres") as Theme

func count_neighbouring_bombs() -> int:
	var count = IntRef.new()
	button_cell.act_on_neighbour_cells(func(cell: CellButton):
		if cell.root_game_cell.contents == CellContents.BOMB:
			count.value += 1
			return true
		return false)
	return count.value

func count_neighbouring_marks() -> int:
	var count = IntRef.new()
	button_cell.act_on_neighbour_cells(func(cell: CellButton):
		if cell.root_game_cell.marked:
			count.value += 1
			return true
		return false)
	return count.value

func act_on_neighbour_cells(action: Callable) -> bool:
	return button_cell.act_on_neighbour_cells(action)
