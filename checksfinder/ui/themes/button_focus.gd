extends Button


func _on_mouse_entered() -> void:
	if not disabled:
		var inner = get_parent()
		set_button_margin_theme("res://checksfinder/ui/themes/darkgreenborder_topleft.tres", inner)
		var outer = inner.get_parent()
		set_button_margin_theme("res://checksfinder/ui/themes/lightgreenborder_bottomright.tres", outer)

func _on_mouse_exited() -> void:
	if not disabled:
		var inner = get_parent()
		set_button_margin_theme("res://checksfinder/ui/themes/darkgreenborder_bottomright.tres", inner)
		var outer = inner.get_parent()
		set_button_margin_theme("res://checksfinder/ui/themes/lightgreenborder_topleft.tres", outer)

func set_button_margin_theme(path: String, margin_node: Node) -> void:
	if path.is_empty(): return
	var theme_res := load(path) as Theme
	if not theme_res: return
	margin_node.theme = theme_res
