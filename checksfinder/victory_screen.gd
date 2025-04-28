extends Button


func _on_pressed() -> void:
	var scene = load("res://checksfinder/Game Scene.tscn").instantiate()
	ChecksFinder.replace_scene(scene)
