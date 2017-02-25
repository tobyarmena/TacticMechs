

with(current_unit)
	{
	var target = argument0
	
	//check if unit can already hit 
	if abs(target.xpos-xpos) + abs(target.ypos-ypos) <= attack_range_max	
		if abs(target.xpos-xpos) + abs(target.ypos-ypos) >= attack_range_min
			{
			scr_wait()
			exit;
			}

	//find target position (position that unit can attack target from)
	for (xx = 0; xx < other.grid_width; xx++)
		for (yy = 0; yy < other.grid_width; yy++)
			{
			other.grid_ai[xx,yy] = 0
			if abs(target.xpos-xx) + abs(target.ypos-yy) <= attack_range_max	
				if abs(target.xpos-xx) + abs(target.ypos-yy) >= attack_range_min
					{
					other.grid_ai[xx,yy] = 1
					}
			}	
	}
//find the closest target position
var startx = current_unit.xpos*grid_size + grid_size/2
var starty = current_unit.ypos*grid_size + grid_size/2
var min_range = 999999
for (xx = 0; xx < grid_width; xx++)
	for (yy = 0; yy < grid_width; yy++)
		{
		if grid_ai[xx,yy] == 1 && grid_occ[xx,yy] == noone
			{
			//find path length of target position
			var endx = xx*grid_size + grid_size/2
			var endy = yy*grid_size + grid_size/2
			check_path = path_add()
			scr_grid_refresh()
			mp_grid_path(grid,check_path,startx,starty,endx,endy,false)
			if path_get_length(check_path) < min_range && path_get_length(check_path) != 0
				{
				min_range = path_get_length(check_path)
				goalx = xx
				goaly = yy
				}
			}
		}
		
//record the goal position on the ai grid
for (xx = 0; xx < grid_width; xx++)
	for (yy = 0; yy < grid_width; yy++)
		grid_ai[xx,yy] = 0
grid_ai[goalx,goaly] = 2


if grid_mov[goalx,goaly] != 1
	{
	//find the closest available position if not in range
	var endx = goalx*grid_size + grid_size/2
	var endy = goaly*grid_size + grid_size/2
	var min_range = 999999
	for (xx = 0; xx < grid_width; xx++)
		for (yy = 0; yy < grid_width; yy++)
			{
			if grid_mov[xx,yy] == 1
				{
				var startx = xx*grid_size + grid_size/2
				var starty = yy*grid_size + grid_size/2
				mp_grid_path(grid,check_path,startx,starty,endx,endy,false)
				if path_get_length(check_path) < min_range && path_get_length(check_path) != 0
					{
					min_range = path_get_length(check_path)
					gox = xx
					goy = yy
					}
				}
			}
	}
else
	{
	gox = goalx
	goy = goaly
	}
		
//check if already in position
if (gox == current_unit.xpos && goy == current_unit.ypos) || (grid_occ[gox,goy] != noone)
	{
	scr_ai_wait()
	}
else
	{
	//go to position
	scr_move(current_unit,gox,goy)
	}




