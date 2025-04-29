class_name ButtonWrapper extends PanelContainer

@export_multiline var button_text: String
@export var button: WrappedButton
@export var disabled: bool = false
@export var hover_enabled: bool = true
signal wrapped_button_pressed

func _ready():
	if button_text:
		button.text = button_text
	button.disabled = disabled

func _on_wrapped_button_pressed() -> void:
	wrapped_button_pressed.emit()
	
func inner_grab_focus():
	button.grab_focus()
