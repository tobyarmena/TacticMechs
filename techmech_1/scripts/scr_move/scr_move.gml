

with(argument0)
	{
	
	
	//Initiate path
	
	if mp_grid_path(ctrl_grid.grid, 
					path, 
					x, 
					y, 
					argument1*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					argument2*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					false)
		{
		
			
		//start path
			
		path_start(path, 5, path_action_stop, 1);
			
		//Set State
			
		state = "moving"
	
	
		//Update position on grid
	
		ctrl_grid.grid_occ[xpos,ypos] = noone
		ctrl_grid.grid_occ[argument1,argument2] = id
	
		//Update position for self
	
		xpos = argument1
		x2pos = argument1+1
		ypos = argument2
		y2pos = argument2+1
			
		}
	}