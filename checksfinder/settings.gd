extends PanelContainer

@export var scale_slider: Slider
@export var volume_container: VolumeContainer

func _ready():
	scale_slider.value = (Archipelago.config as ChecksFinderConfigManager).scale

func _on_exit_pressed() -> void:
	$ClickSound.finished.connect(func():
		if not volume_container.timer.is_stopped():
			await volume_container.timer.timeout
		(Archipelago.config as ChecksFinderConfigManager).scale = scale_slider.value
		get_tree().root.content_scale_factor = scale_slider.value
		var scene = load("res://checksfinder/Start Menu.tscn").instantiate()
		ChecksFinder.replace_scene(scene)
		)
	$ClickSound.play()
