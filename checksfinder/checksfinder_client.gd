@tool class_name ChecksFinderClient extends ConsoleWindowContainer

@export var checksfinder_tab: MarginContainer

func _ready():
	super()
	if Engine.is_editor_hint():
		return
	Archipelago.load_console(self, false)
