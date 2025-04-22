extends HSlider


@export var audio_bus_name := "Master"

@onready var _bus := AudioServer.get_bus_index(audio_bus_name)


func _ready() -> void:
	value = AudioServer.get_bus_volume_linear(_bus)


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(_bus, value)
