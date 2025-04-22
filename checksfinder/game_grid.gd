extends GridContainer

var children: Array[Node] = []

func _enter_tree() -> void:
	for i in range(25):
		var cell = load("res://checksfinder/Game Cell.tscn").instantiate()
		add_child.call_deferred(cell)
		children.append(cell)
	children[0].ready.connect(func(): children[0].game_cell.grab_focus(), CONNECT_ONE_SHOT)
	
