with(ctrl_grid)
	{
	if parent == par_ride
		{
		scr_update_map()
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
	else if parent == par_unit
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