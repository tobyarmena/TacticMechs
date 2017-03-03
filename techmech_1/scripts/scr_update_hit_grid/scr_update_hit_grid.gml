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
					for (xx = xp - attack_range_max; xx <= xp + attack_range_max; xx ++)
						for (yy = yp - attack_range_max; yy <= yp + attack_range_max; yy ++)
							{
							if abs(xx-xp) + abs(yy-yp) <= attack_range_max
								if abs(xx-xp) + abs(yy-yp) >= attack_range_min
									{
									if xx >= 0 && yy >= 0
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
			for (xx = xp - attack_range_max; xx <= xp + attack_range_max; xx ++)
				for (yy = yp - attack_range_max; yy <= yp + attack_range_max; yy ++)
					{
					if abs(xx-xp) + abs(yy-yp) <= attack_range_max
						if abs(xx-xp) + abs(yy-yp) >= attack_range_min
							{
							if xx >= 0 && yy >= 0
								if other.grid_occ[xx,yy] != id
									other.grid_hit[xx,yy] = 1
							}
					}
			}
		}
	}