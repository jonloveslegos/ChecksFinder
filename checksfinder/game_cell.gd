class_name GameCell extends PanelContainer


@onready var button_cell: CellButton = get_node("PanelContainer/PanelContainer/Button Cell")
@onready var label: Label = get_node("PanelContainer/PanelContainer/Panel/Label")

enum CellContents{
	UNSET, BOMB, NUMBER
}
var contents: CellContents = CellContents.UNSET
var revealed = false
var marked = false
signal pressed(cell: GameCell)

func _ready():
	button_cell.root_game_cell = self
	button_cell.label = label

func _on_button_cell_pressed() -> void:
	pressed.emit(self)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not marked and not revealed:
			revealed = true
			update_graphics()
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if not revealed:
			if marked:
				marked = false
			else:
				marked = true
			update_graphics()

func update_graphics() -> void:
	if not revealed:
		if marked:
			label.get_parent().theme = load("res://checksfinder/ui/themes/x_mark.tres") as Theme
		else:
			label.get_parent().theme = load("res://checksfinder/ui/themes/empty.tres") as Theme
	else:
		button_cell.disabled = true
		var inner = button_cell.get_parent()
		inner.theme = load("res://checksfinder/ui/themes/darkbrownborder_bottomright.tres") as Theme
		var outer = inner.get_parent()
		outer.theme = load("res://checksfinder/ui/themes/lightbrownborder_topleft.tres") as Theme
		match contents:
			CellContents.BOMB:
				label.get_parent().theme = load("res://checksfinder/ui/themes/bomb.tres") as Theme
			CellContents.NUMBER:
				var panel = label.get_parent() as Panel
				panel.theme = load("res://checksfinder/ui/themes/empty.tres") as Theme
				label.text = "0"
			CellContents.UNSET:
				label.get_parent().theme = load("res://checksfinder/ui/themes/x_mark.tres") as Theme
		
