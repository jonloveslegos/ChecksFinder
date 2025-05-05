class_name LabeledContainer extends VBoxContainer

@export var label: Label

@export_multiline var text: String
@export var font_size: int = -1

func _ready():
	label.text = text
	if font_size >= 0:
		label.add_theme_font_size_override("font_size", font_size)
