extends Control

func _ready():
	var viewport = get_viewport()
	viewport.disable_3d = true
	viewport.gui_embed_subwindows = false
	
