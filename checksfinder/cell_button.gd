class_name CellButton extends WrappedButton

@export var root_game_cell: GameCell
@export var label: Label

func act_on_neighbour_cells(action: Callable) -> bool:
	var has_acted = false
	var left = find_valid_focus_neighbor(SIDE_LEFT)
	if is_instance_valid(left) and left is CellButton:
		if action.call(left):
			has_acted = true
	var right = find_valid_focus_neighbor(SIDE_RIGHT)
	if is_instance_valid(right) and right is CellButton:
		if action.call(right):
			has_acted = true
	var top = find_valid_focus_neighbor(SIDE_TOP)
	if is_instance_valid(top) and top is CellButton:
		if action.call(top):
			has_acted = true
		var top_left = top.find_valid_focus_neighbor(SIDE_LEFT)
		if is_instance_valid(top_left) and top_left is CellButton:
			if action.call(top_left):
				has_acted = true
		var top_right = top.find_valid_focus_neighbor(SIDE_RIGHT)
		if is_instance_valid(top_right) and top_right is CellButton:
			if action.call(top_right):
				has_acted = true
	var bottom = find_valid_focus_neighbor(SIDE_BOTTOM)
	if is_instance_valid(bottom) and bottom is CellButton:
		if action.call(bottom):
			has_acted = true
		var bottom_left = bottom.find_valid_focus_neighbor(SIDE_LEFT)
		if is_instance_valid(bottom_left) and bottom_left is CellButton:
			if action.call(bottom_left):
				has_acted = true
		var bottom_right = bottom.find_valid_focus_neighbor(SIDE_RIGHT)
		if is_instance_valid(bottom_right) and bottom_right is CellButton:
			if action.call(bottom_right):
				has_acted = true
	return has_acted
