//Set movable and hittable positions positions for unit
scr_reset_movhit()
with(current_unit)
	{
	scr_grid_refresh()
	var par = object_get_parent(id.object_index)
	if par == par_unit
		{
		for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
			for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
				{
				
				if mp_grid_path(other.grid,path,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false)
					{
					if path_get_length(path)/ctrl_grid.grid_size <= move_range
						{
						other.grid_mov[xx,yy] = 1
										
						//Set hittable positions
						for (xxx = xx-attack_range_max;xxx <= xx+attack_range_max;xxx++)
							for (yyy = yy-attack_range_max;yyy <= yy+attack_range_max;yyy++)
								{
								if abs(xxx-xx)+ abs(yyy-yy) <= attack_range_max
									if abs(xxx-xx)+ abs(yyy-yy) >= attack_range_min
										{
										if xxx >= 0 && yyy >= 0
											other.grid_hit[xxx,yyy] = 1
										}
								}
										
										
						}
					}
				}
		}
	else if par == par_ride
		{
		for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
			for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
				{
				
				if mp_grid_path_2x2(other.grid,path,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false)
					{
					if path_get_length(path)/ctrl_grid.grid_size <= move_range
						{
						other.grid_mov[xx,yy] = 1
										
						//Set hittable positions
						for(xxxx = 0;xxxx < 2 ;xxxx++)
							for(yyyy = 0;yyyy < 2 ;yyyy++)
								for (xxx = xx+xxxx-attack_range_max;xxx <= xx+xxxx+attack_range_max;xxx++)
									for (yyy = yy+yyyy-attack_range_max;yyy <= yy+yyyy+attack_range_max;yyy++)
										{
										if abs(xxx-xx)+ abs(yyy-yy) <= attack_range_max
											if abs(xxx-xx)+ abs(yyy-yy) >= attack_range_min
												{
												if xxx >= 0 && yyy >= 0
													other.grid_hit[xxx,yyy] = 1
												}
										}
										
										
						}
					}
				}
		}
	}