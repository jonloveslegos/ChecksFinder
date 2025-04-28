class_name VolumeContainer extends VBoxContainer

@export var label: Label
@export var label_font_size: int = -1
@export var option_button: OptionButton
@export var volume_slider: HSlider

func _ready():
	if label_font_size >= 0:
		label.add_theme_font_size_override("font_size", label_font_size)
