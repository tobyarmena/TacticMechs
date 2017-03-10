

with(argument0)
	{
	
	
	//Initiate path
	
	with(ctrl_grid)
		scr_reset_movhit()
	
	with(par_wall)
		{
		mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size)-1)
		mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size),floor(y/ctrl_grid.grid_size)-1)
		mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size))
		}
	with(par_unit)
		{
		if team != argument3
			{
			mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size)-1)
			mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size),floor(y/ctrl_grid.grid_size)-1)
			mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size))
			}
		}
	//top left path
	if mp_grid_path(ctrl_grid.grid, 
					path1, 
					x, 
					y, 
					argument1*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					argument2*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					false)
	{
	scr_grid_refresh()
	//top right path
	if mp_grid_path(ctrl_grid.grid, 
					path2, 
					x+ctrl_grid.grid_size, 
					y, 
					argument1*ctrl_grid.grid_size+ctrl_grid.grid_size/2+ctrl_grid.grid_size, 
					argument2*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					false)
	{
	//bottom left path
	if mp_grid_path(ctrl_grid.grid, 
					path3, 
					x, 
					y+ctrl_grid.grid_size, 
					argument1*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					argument2*ctrl_grid.grid_size+ctrl_grid.grid_size/2+ctrl_grid.grid_size, 
					false)
	{
	//bottom right path
	if mp_grid_path(ctrl_grid.grid, 
					path4, 
					x+ctrl_grid.grid_size, 
					y+ctrl_grid.grid_size, 
					argument1*ctrl_grid.grid_size+ctrl_grid.grid_size/2+ctrl_grid.grid_size, 
					argument2*ctrl_grid.grid_size+ctrl_grid.grid_size/2+ctrl_grid.grid_size, 
					false)
		{
		//start path
			
		path_start(path1, 5, path_action_stop, 1);
			
		//Set State
			
		state = "moving"
	
	
		//Update position on grid
	
		ctrl_grid.grid_occ[xpos,ypos] = noone
		ctrl_grid.grid_occ[xpos+1,ypos] = noone
		ctrl_grid.grid_occ[xpos,ypos+1] = noone
		ctrl_grid.grid_occ[xpos+1,ypos+1] = noone
		
		ctrl_grid.grid_occ[argument1,argument2] = id
		ctrl_grid.grid_occ[argument1+1,argument2] = id
		ctrl_grid.grid_occ[argument1,argument2+1] = id
		ctrl_grid.grid_occ[argument1+1,argument2+1] = id
	
		//Update position for self
	
		xpos = argument1
		ypos = argument2
			
		}
	}
	}
	}
	
	
	}