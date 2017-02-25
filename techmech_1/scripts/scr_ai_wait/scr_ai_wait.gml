with(current_unit)
	{
	path_position = 0 
	state = "wait"
	other.state = "command"
	other.current_unit = noone
	other.grid_updated = false
	other.action_complete = true
	scr_update_hit_grid()
	}