//argument0 = min range
//argument1 = max range
//argument2 = ignore walls? true/false
var hitwall = argument2


with(ctrl_grid)
	{
	var p = object_get_parent(current_unit.object_index)
	if p == par_ride
		{
		scr_reset_movhit()
		scr_grid_refresh()
		
		with(current_unit)
			for (xp = xpos; xp <= xpos+1; xp++)
				for (yp = ypos; yp <= ypos+1; yp++)
					for (xx = xp - argument1; xx <= xp + argument1; xx ++)
						for (yy = yp - argument1; yy <= yp + argument1; yy ++)
							{
							if abs(xx-xp) + abs(yy-yp) <= argument1
								if abs(xx-xp) + abs(yy-yp) >= argument0
									{
									if xx >= 0 && yy >= 0
										if (argument2 == false || !position_meeting(xx*other.grid_size,yy*other.grid_size,par_wall))
										if other.grid_occ[xx,yy] != id
											other.grid_hit[xx,yy] = 1
									}
							}
			
		}
	else if p == par_unit
		{
		with(current_unit)
			{
			var xp = xpos
			var yp = ypos
			for (xx = xp - argument1; xx <= xp + argument1; xx ++)
				for (yy = yp - argument1; yy <= yp + argument1; yy ++)
					{
					if abs(xx-xp) + abs(yy-yp) <= argument1
						if abs(xx-xp) + abs(yy-yp) >= argument0
							{
							if xx >= 0 && yy >= 0
								if other.grid_occ[xx,yy] != id
									other.grid_hit[xx,yy] = 1
							}
					}
			}
		}
	}