with(argument0)
	{
	ctrl_grid.grid_occ[xpos,ypos] = noone
	if team == 1
		ds_list_delete(ctrl_grid.team1,ds_list_find_index(ctrl_grid.team1,id))
	else if team == 2
		ds_list_delete(ctrl_grid.team2,ds_list_find_index(ctrl_grid.team2,id))
	instance_destroy()
	}
scr_update_unsafe_grid()