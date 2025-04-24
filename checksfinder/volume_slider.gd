extends HSlider

@export var option_button: OptionButton
@onready var audio_bus_name = option_button.get_item_text(option_button.selected)
@onready var _bus = AudioServer.get_bus_index(audio_bus_name)
@onready var _volume = Archipelago.config.volume_storage

func _ready() -> void:
	value = _volume.get_volume(audio_bus_name)

func _on_value_changed(n_value: float) -> void:
	AudioServer.set_bus_volume_linear(_bus, n_value)
	_volume.set_volume(audio_bus_name, n_value)

func _on_option_button_item_selected(index: int) -> void:
	audio_bus_name = option_button.get_item_text(index)
	_bus = AudioServer.get_bus_index(audio_bus_name)
	value = AudioServer.get_bus_volume_linear(_bus)
