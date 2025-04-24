extends GridContainer

enum GameState{
	EMPTY, GENERATING, PLAYING, LOST, VICTORY
}
var game_state = GameState.EMPTY

var children: Array[Control] = []
@onready var height = ChecksFinder.get_height()
@onready var width = ChecksFinder.get_width()
@onready var bombs = ChecksFinder.get_bombs()


func _ready() -> void:
	columns = width
	for i in range(width * height):
		var cell = load("res://checksfinder/Game Cell.tscn").instantiate() as GameCell
		add_child.call_deferred(cell)
		children.append(cell)
		cell.pressed.connect($"../.."._on_game_cell_pressed)
		cell.contents = GameCell.CellContents.NUMBER
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

func _gui_input(event: InputEvent) -> void:
		if ChecksFinder.has_used_ui_buttons or ChecksFinder.is_event_ui(event):
			if get_viewport().gui_get_focus_owner() == null:
				children[0].game_cell.grab_focus()
			for child in children:
				child.focus_mode = Control.FOCUS_ALL
			ChecksFinder.has_used_ui_buttons = true
