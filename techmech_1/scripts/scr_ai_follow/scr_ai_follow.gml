var par_me = object_get_parent(current_unit.object_index)
with(current_unit)
	{
	var target = argument0
	var par = object_get_parent(target.object_index)
	
	//check if unit can already hit 
	if par == par_unit && par_me = par_unit
		{
		if abs(target.xpos-xpos) + abs(target.ypos-ypos) <= attack_range_max	
			if abs(target.xpos-xpos) + abs(target.ypos-ypos) >= attack_range_min
				{
				with(other)
					scr_ai_action()
				exit;
				}
		}
	else if par == par_ride && par_me = par_unit
		{
		for(xx = 0 ; xx <2 ; xx++)
			for(yy = 0 ; yy <2 ; yy++)
				if abs(target.xpos+xx-xpos) + abs(target.ypos+yy-ypos) <= attack_range_max	
					if abs(target.xpos+xx-xpos) + abs(target.ypos+yy-ypos) >= attack_range_min
						{
						with(other)
							scr_ai_action()
						exit;
						}
		}
	else if par_unit && par_me == par_ride 
		{
		for(xx = 0 ; xx <2 ; xx++)
			for(yy = 0 ; yy <2 ; yy++)
				if abs(target.xpos-xx-xpos) + abs(target.ypos-yy-ypos) <= attack_range_max	
					if abs(target.xpos-xx-xpos) + abs(target.ypos-yy-ypos) >= attack_range_min
						{
						with(other)
							scr_ai_action()
						exit;
						}
		}
	else if par_ride && par_me == par_ride 
		{
		for(xx = -1 ; xx <2 ; xx++)
			for(yy = -1 ; yy <2 ; yy++)
				if abs(target.xpos-xx-xpos) + abs(target.ypos-yy-ypos) <= attack_range_max	
					if abs(target.xpos-xx-xpos) + abs(target.ypos-yy-ypos) >= attack_range_min
						{
						
						with(other)
							scr_ai_action()
						exit;
						}
		}
	
	//find target position (position that unit can attack target from)
	if par == par_unit && par_me == par_unit
		{
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
	else if par == par_ride && par_me == par_unit
		{
		for (xx = 0; xx < other.grid_width; xx++)
			for (yy = 0; yy < other.grid_width; yy++)
				other.grid_ai[xx,yy] = 0
		for(xxx = 0 ; xxx <2 ; xxx++)
			for(yyy = 0 ; yyy <2 ; yyy++)
				for (xx = 0; xx < other.grid_width; xx++)
					for (yy = 0; yy < other.grid_width; yy++)
						{
						if abs(target.xpos-xx+xxx) + abs(target.ypos-yy+yyy) <= attack_range_max	
							if abs(target.xpos-xx+xxx) + abs(target.ypos-yy+yyy) >= attack_range_min
								{
								other.grid_ai[xx,yy] = 1
								}
						}
		}
	else if par == par_unit && par_me == par_ride
		{
		for (xx = 0; xx < other.grid_width; xx++)
			for (yy = 0; yy < other.grid_width; yy++)
				other.grid_ai[xx,yy] = 0
	
		for (xx = 0; xx < other.grid_width; xx++)
			for (yy = 0; yy < other.grid_width; yy++)
				for(xxx = 0 ; xxx <2 ; xxx++)
					for(yyy = 0 ; yyy <2 ; yyy++)
						{
						if abs(target.xpos-xx-xxx) + abs(target.ypos-yy-yyy) <= attack_range_max	
							if abs(target.xpos-xx-xxx) + abs(target.ypos-yy-yyy) >= attack_range_min
								{
								other.grid_ai[xx,yy] = 1
								}
						}
		}
	else if par == par_ride && par_me == par_ride
		{
		for (xx = 0; xx < other.grid_width; xx++)
			for (yy = 0; yy < other.grid_width; yy++)
				other.grid_ai[xx,yy] = 0
		for(xxx = -1 ; xxx <2 ; xxx++)
			for(yyy = -1 ; yyy <2 ; yyy++)
				for (xx = 0; xx < other.grid_width; xx++)
					for (yy = 0; yy < other.grid_width; yy++)
						{
						if abs(target.xpos-xx-xxx) + abs(target.ypos-yy-yyy) <= attack_range_max	
							if abs(target.xpos-xx-xxx) + abs(target.ypos-yy-yyy) >= attack_range_min
								{
								other.grid_ai[xx,yy] = 1
								}
						}
		}
	
	}
//find the closest target position
var startx = current_unit.xpos*grid_size + grid_size/2
var starty = current_unit.ypos*grid_size + grid_size/2
goalx = 0
goaly = 0
var min_range = 999999


for (xx = 0; xx < grid_width; xx++)
	for (yy = 0; yy < grid_width; yy++)
		{
		if grid_ai[xx,yy] == 1 && (grid_occ[xx,yy] == noone || grid_occ[xx,yy] == current_unit)
			{
			//find path length of target position
			var endx = xx*grid_size + grid_size/2
			var endy = yy*grid_size + grid_size/2
			check_path = path_add()
			scr_grid_refresh()
			if par_me == par_unit
				mp_grid_path(grid,check_path,startx,starty,endx,endy,false)
			else if par_me == par_ride
				mp_grid_path_2x2(grid,check_path,startx,starty,endx,endy,false,2)
			var check_space = grid_occ[xx,yy] == noone 
						&& grid_occ[xx+1,yy+1] == noone
						&& grid_occ[xx,yy+1] == noone
						&& grid_occ[xx+1,yy] == noone
			if par_me == par_unit || (par_me = par_ride && check_space == true)
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
	for (yy = 0; yy < grid_height; yy++)
		grid_ai[xx,yy] = 0
grid_ai[goalx,goaly] = 2


if grid_mov[goalx,goaly] != 1
	{
	//find the closest available position if not in range
	var endx = goalx*grid_size + grid_size/2
	var endy = goaly*grid_size + grid_size/2
	var min_range = 999999
	for (xx = 0; xx < grid_width; xx++)
		for (yy = 0; yy < grid_height; yy++)
			{
			if xx>=0 && yy>=0
				{
				if grid_mov[xx,yy] == 1
					{
					var startx = xx*grid_size + grid_size/2
					var starty = yy*grid_size + grid_size/2
					if par_me == par_unit
						mp_grid_path(grid,check_path,startx,starty,endx,endy,false)
					else if par_me == par_ride
						mp_grid_path_2x2(grid,check_path,startx,starty,endx,endy,false,2)
						
					var check_space = grid_occ[xx,yy] == noone 
						&& grid_occ[xx+1,yy+1] == noone
						&& grid_occ[xx,yy+1] == noone
						&& grid_occ[xx+1,yy] == noone
					
					if par_me == par_unit || (par_me == par_ride && check_space == true) 	
						if path_get_length(check_path) < min_range && path_get_length(check_path) != 0
							{
							min_range = path_get_length(check_path)
							gox = xx
							goy = yy
							}
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
if (gox == current_unit.xpos && goy == current_unit.ypos) || ((grid_occ[gox,goy] != noone)&&(grid_occ[gox,goy] != current_unit))
	{
	scr_ai_action()
	}
else
	{
	//go to position
	if par_me = par_unit
		scr_move(current_unit,gox,goy)
	else if par_me = par_ride
		scr_move_ride(current_unit,gox,goy,current_unit.team)
	}




