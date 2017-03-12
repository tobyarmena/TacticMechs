
with(ctrl_grid)
{
for (xx = 0; xx < grid_width;xx+=1)
	{
	for (yy = 0; yy < grid_height;yy+=1)
		{
		grid_unsafe[xx,yy] = 0
		}
	}

for (g = 0; g < ds_list_size(team2); g++)
	{
	var inst = ds_list_find_value(team2,g)
	var pars = object_get_parent(inst.object_index)
	scr_grid_refresh_team(2)
	//Set movable positions for unit
	if pars == par_ride
		{
		with(inst)
			{
			for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
				for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
					{
					if mp_grid_path_2x2(other.grid,path1,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false,team)
						{
						if path_get_length(path1)/ctrl_grid.grid_size <= move_range
							{					
							//Set hittable positions
							for (xp = xx; xp <= xx+1;xp++)
								for (yp = yy; yp <= yy+1;yp++)
									for (xxx = xp-attack_range_max;xxx <= xp+attack_range_max;xxx++)
										for (yyy = yp-attack_range_max;yyy <= yp+attack_range_max;yyy++)
											{
											if scr_check_in_range(xxx,yyy,xp,yp,attack_range_min,attack_range_max)
												{
												if xxx>= 0 && yyy >= 0
													{
													other.grid_unsafe[xxx,yyy] = 1
													}
												}
											}
							}
						}
					}
			}
		}
	
	else if pars == par_unit
		{
		with(inst)
			{
			for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
				for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
					{	
					
					if mp_grid_path(other.grid,path,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false)
						{
						if path_get_length(path)/ctrl_grid.grid_size <= move_range
							{			
							//Set hittable positions
							for (xxx = xx-attack_range_max;xxx <= xx+attack_range_max;xxx++)
								for (yyy = yy-attack_range_max;yyy <= yy+attack_range_max;yyy++)
									{
									if scr_check_in_range(xxx,yyy,xx,yy,attack_range_min,attack_range_max)
										{
										if xxx>=0 && yyy>=0
											{
											other.grid_unsafe[xxx,yyy] = 1
											}
										}
									}			
							}
						}
					}
			}
		}
	
	}
scr_grid_refresh()
}