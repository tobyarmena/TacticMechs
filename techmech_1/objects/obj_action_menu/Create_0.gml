/// @description Insert description here
// You can write your code in this editor

startx = x
starty = y

var num = 0

option[num,0] = "wait"
option[num,1] = scr_wait
num++

//Check if attacking is an option
var num_check = num
with(ctrl_grid)
	{
	for(xx = 0 ; xx < grid_width ; xx += 1)
		{
		for(yy = 0 ; yy < grid_height ; yy += 1)
			{
			if grid_hit[xx,yy] == 1
				{
				if grid_occ[xx,yy] != noone
					{
					if grid_occ[xx,yy].team != current_unit.team
						{
						with(other)
							{
							if num_check == num	
								{
								option[num,0] = "attack"
								option[num,1] = scr_attack
								num++
								}
							}
						}
					}
				}
			}
		}
	}
var num_check = num
//check if occupying a vehicle is an option
var unit = ctrl_grid.current_unit
if object_get_parent(unit.object_index)== par_unit
	{
	for(xx=unit.xpos-1;xx<=unit.xpos+1;xx++)
		for(yy=unit.ypos-1;yy<=unit.ypos+1;yy++)
			{
			if scr_check_in_range(unit.xpos,unit.ypos,xx,yy,1,1)
				{
				if ctrl_grid.grid_occ[xx,yy] != noone
					{
					if object_get_parent(ctrl_grid.grid_occ[xx,yy].object_index)== par_ride
						{
						if ctrl_grid.grid_occ[xx,yy].team == 0
							{
							if num_check == num	
								{
								option[num,0] = "occupy"
								option[num,1] = scr_occupy
								num++
								}
							}
						}
					}
				}
			}
	}
	
//check if leaving a vehicle is an option
if object_get_parent(unit.object_index)== par_ride
	{
	if unit.pilot != noone
		{
		if num_check == num	
			{
			option[num,0] = "unoccupy"
			option[num,1] = scr_unoccupy
			num++
			}
		}
	}
//Check if covering is an option
var num_check = num
with(ctrl_grid)
	{
	for(xx = 0 ; xx < grid_width ; xx += 1)
		{
		for(yy = 0 ; yy < grid_height ; yy += 1)
			{
			if grid_hit[xx,yy] == 1
				{
				if grid_occ[xx,yy] != noone
					{
					if grid_occ[xx,yy].team == current_unit.team && grid_occ[xx,yy].covering = false && grid_occ[xx,yy].coverer == noone && grid_occ[xx,yy].state == "wait"
						{
						with(other)
							{
							if num_check == num	
								{
								option[num,0] = "cover"
								option[num,1] = scr_cover
								num++
								}
							}
						}
					}
				}
			}
		}
	}


draw_set_font(fnt_menu)




//find max width

box_width = 0
box_height = string_height(option[0,0])
for(i = 0 ; i < array_height_2d(option) ; i++)
	{
	var width = string_width(option[i,0])
	if width > box_width
		box_width = width
	}
