

with(argument0)
	{
	
	
	//Initiate path
	
	if mp_grid_path(ctrl_grid.grid2, 
					path, 
					x, 
					y, 
					argument1*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					argument2*ctrl_grid.grid_size+ctrl_grid.grid_size/2, 
					false)
		{
		
		ctrl_grid.grid_occ[xpos,ypos] = noone
		//start path
			
		path_start(path, 5, path_action_stop, 1);
			
		
	
			
		}
	}