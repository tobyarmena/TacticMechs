with(par_wall)
	{
	mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size)-1)
	mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size),floor(y/ctrl_grid.grid_size)-1)
	mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size))
	}
with(par_unit)
	{
	if team != argument7
		{
		mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size)-1)
		mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size),floor(y/ctrl_grid.grid_size)-1)
		mp_grid_add_cell(ctrl_grid.grid,floor(x/ctrl_grid.grid_size)-1,floor(y/ctrl_grid.grid_size))
		}
	}
return mp_grid_path(argument0, 
					argument1, 
					argument2, 
					argument3, 
					argument4, 
					argument5, 
					argument6,)
scr_grid_refresh()