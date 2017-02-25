//empty movable position grid
		
for (xx = 0 ; xx <= grid_width ; xx++)
	for (yy = 0 ; yy <=  grid_height ; yy++)
		{
		grid_mov[xx,yy] = 0
		grid_hit[xx,yy] = 0
		}
/*
if instance_exists(par_unit)
	with(par_unit)
		{
		mp_grid_add_cell(ctrl_grid.grid,x/ctrl_grid.grid_size,y/ctrl_grid.grid_size)
		}
		
