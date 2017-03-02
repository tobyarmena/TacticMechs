with(ctrl_grid)
	{
	mp_grid_clear_all(grid);
	
	mp_grid_add_instances(grid,par_unit,false)
	mp_grid_add_instances(grid,par_wall,false)
	mp_grid_add_instances(grid,par_ride,false)
	
	var teamlist
	if argument0 == 1
		teamlist = team1
	else if argument0 == 2
		teamlist = team2
		
	for(i = 0;i < ds_list_size(teamlist);i++)
		{
		var unit = ds_list_find_value(teamlist,i)
		var par = object_get_parent(unit.object_index)
		
	
		if unit != noone
			{
			if par == par_unit
				{
				mp_grid_clear_cell(grid,unit.xpos,unit.ypos)
				}
			else if par == par_ride
				{
				mp_grid_clear_cell(grid,unit.xpos,unit.ypos)
				mp_grid_clear_cell(grid,unit.xpos+1,unit.ypos)
				mp_grid_clear_cell(grid,unit.xpos,unit.ypos+1)
				mp_grid_clear_cell(grid,unit.xpos+1,unit.ypos+1)
				}
			}
		/*
		else if par == par_ride
			{
			var inst = grid_occ[mouse_xxx,mouse_yyy]
			mp_grid_clear_cell(grid,inst.xpos,inst.ypos)
			mp_grid_clear_cell(grid,inst.xpos+1,inst.ypos)
			mp_grid_clear_cell(grid,inst.xpos,inst.ypos+1)
			mp_grid_clear_cell(grid,inst.xpos+1,inst.ypos+1)
			}
		else if parent == par_unit
			{
			var inst = grid_occ[mouse_xxx,mouse_yyy]
			mp_grid_clear_cell(grid,inst.xpos,inst.ypos)
			}
			*/
		}

		
	
	
	}