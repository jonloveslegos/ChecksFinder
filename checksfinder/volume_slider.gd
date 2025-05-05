extends HSlider

@export var option_button: OptionButton
@export var timer: Timer
@onready var audio_bus_name = option_button.get_item_text(option_button.selected)
@onready var _bus = AudioServer.get_bus_index(audio_bus_name)
@onready var _volume = Archipelago.config.volume_storage
var new_value: float

func _ready() -> void:
	value = _volume.get_volume(audio_bus_name)

func _on_value_changed(n_value: float) -> void:
	AudioServer.set_bus_volume_linear(_bus, n_value)
	new_value = n_value
	timer.start(1)

func _on_option_button_item_selected(index: int) -> void:
	audio_bus_name = option_button.get_item_text(index)
	_bus = AudioServer.get_bus_index(audio_bus_name)
	value = AudioServer.get_bus_volume_linear(_bus)

func _on_timer_timeout() -> void:
	_volume.set_volume(audio_bus_name, new_value)
