//Set movable and hittable positions positions for unit
scr_update_map()
with(current_unit)
	{
	scr_grid_refresh()
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