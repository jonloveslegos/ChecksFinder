class_name CellButton extends WrappedButton

var root_game_cell: GameCell
var label: Label

func act_on_neighbour_cells(action: Callable) -> void:
	var left = find_valid_focus_neighbor(SIDE_LEFT)
	if is_instance_valid(left) and left is CellButton:
		action.call(left)
	var right = find_valid_focus_neighbor(SIDE_RIGHT)
	if is_instance_valid(right) and right is CellButton:
		action.call(right)
	var top = find_valid_focus_neighbor(SIDE_TOP)
	if is_instance_valid(top) and top is CellButton:
		action.call(top)
		var top_left = top.find_valid_focus_neighbor(SIDE_LEFT)
		if is_instance_valid(top_left) and top_left is CellButton:
			action.call(top_left)
		var top_right = top.find_valid_focus_neighbor(SIDE_RIGHT)
		if is_instance_valid(top_right) and top_right is CellButton:
			action.call(top_right)
	var bottom = find_valid_focus_neighbor(SIDE_BOTTOM)
	if is_instance_valid(bottom) and bottom is CellButton:
		action.call(bottom)
		var bottom_left = bottom.find_valid_focus_neighbor(SIDE_LEFT)
		if is_instance_valid(bottom_left) and bottom_left is CellButton:
			action.call(bottom_left)
		var bottom_right = bottom.find_valid_focus_neighbor(SIDE_RIGHT)
		if is_instance_valid(bottom_right) and bottom_right is CellButton:
			action.call(bottom_right)
		
