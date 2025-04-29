class_name WrappedButton extends Button

@export var inner: PanelContainer
@export var outer: ButtonWrapper
var inner_theme_normal: String = "res://checksfinder/ui/themes/darkgreenborder_bottomright.tres"
var inner_theme_hover: String = "res://checksfinder/ui/themes/darkgreenborder_topleft.tres"
var outer_theme_normal: String = "res://checksfinder/ui/themes/lightgreenborder_topleft.tres"
var outer_theme_hover: String = "res://checksfinder/ui/themes/lightgreenborder_bottomright.tres"

func _on_mouse_entered() -> void:
	if not disabled and outer.hover_enabled:
		set_button_margin_theme(inner_theme_hover, inner)
		set_button_margin_theme(outer_theme_hover, outer)

func _on_mouse_exited() -> void:
	set_button_margin_theme(inner_theme_normal, inner)
	set_button_margin_theme(outer_theme_normal, outer)

func set_button_margin_theme(path: String, margin_node: Control) -> void:
	if path.is_empty(): return
	var theme_res := load(path) as Theme
	if not theme_res: return
	margin_node.theme = theme_res
