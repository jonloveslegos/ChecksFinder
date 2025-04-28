class_name GameScene extends PanelContainer

@export var dig_sound: AudioStreamPlayer
@export var explosion_sound: AudioStreamPlayer
@export var generic_win_sound: AudioStreamPlayer

@export var InLogic: Label
@export var CompletedChecks: Label

@export var CurrentBombs: Label
@export var CurrentMaxBombs: Label

@export var CurrentHeight: Label
@export var CurrentMaxHeight: Label

@export var CurrentWidth: Label
@export var CurrentMaxWidth: Label

@export var MarkedMines: Label
@export var TotalCurrentMines: Label

@export var DisconnectScreen: PanelContainer
@export var VictoryScreen: PanelContainer
@export var game_grid: GameGrid
@export var volume_container: VolumeContainer
@export var exit: ButtonWrapper

func number_to_text(number: int, digit_count: int) -> String:
	var _str = str(number)
	while _str.length() < digit_count:
		_str = '0' + _str
	return _str

func _ready() -> void:
	ChecksFinder.update_item_info.connect(_on_update_item_info)
	set_info()
	Archipelago.disconnected.connect(_on_disconnect)
	ChecksFinder.changed_connection.connect(_on_changed_connection)
	ChecksFinder.item_status_updated.connect(_on_item_status_updated)

func _on_update_item_info():
	set_info()

func set_info():
	InLogic.text = number_to_text(ChecksFinder.get_count_in_logic(), 2)
	CompletedChecks.text = number_to_text(ChecksFinder.get_completed_count(), 2)
	CurrentBombs.text = number_to_text(game_grid.bombs, 2)
	CurrentMaxBombs.text = number_to_text(ChecksFinder.get_all_bombs(), 2)
	CurrentHeight.text = number_to_text(game_grid.height, 2)
	CurrentMaxHeight.text = number_to_text(ChecksFinder.get_all_height(), 2)
	CurrentWidth.text = number_to_text(game_grid.width, 2)
	CurrentMaxWidth.text = number_to_text(ChecksFinder.get_all_width(), 2)
	TotalCurrentMines.text = number_to_text(game_grid.mine_count, 2)

func _on_updated_marked_mines(count: int) -> void:
	MarkedMines.text = number_to_text(count, 2)
	if count > game_grid.mine_count:
		MarkedMines.theme = load("res://checksfinder/ui/themes/error_text.tres") as Theme
	else:
		MarkedMines.theme = load("res://checksfinder/ui/themes/empty.tres") as Theme

func _on_exit_pressed() -> void:
	$DigSound.finished.connect(func():
		var scene = load("res://checksfinder/Start Menu.tscn").instantiate()
		Archipelago.ap_disconnect()
		ChecksFinder.item_status = CF.ItemStatus.NO_ITEMS
		ChecksFinder.music.stop_gradually()
		ChecksFinder.replace_scene(scene), CONNECT_ONE_SHOT)
	$DigSound.play()

func play_sound(sound_type):
	match sound_type:
		SoundType.DIG:
			$DigSound.play()
		SoundType.EXPLOSION:
			$Explosion.play()
		SoundType.GENERIC_WIN:
			$GenericWin.play()

func _on_game_cell_pressed_sound(sound_type) -> void:
	play_sound(sound_type)

func _on_game_grid_sound(sound_type) -> void:
	play_sound(sound_type)

func _on_disconnect() -> void:
	DisconnectScreen.visible = true

func _on_changed_connection() -> void:
	ChecksFinder.replace_scene(load("res://checksfinder/Game Scene.tscn").instantiate())

func _on_item_status_updated() -> void:
	DisconnectScreen.visible = false
