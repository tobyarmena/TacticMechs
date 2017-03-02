

//adjust the sprite position to match the grid

sprite_set_offset(sprite_index,16,16)
x+=16
y+=16

//Set sprites

sprite_idle = spr_unit_default
sprite_run_right = spr_unit_default_run_right
sprite_run_left = spr_unit_default_run_left
sprite_run_up = spr_unit_default_run_up
sprite_run_down = spr_unit_default_run_down

//Set variables

path = path_add()
state = "wait"
move_range = 8
attack_range_max = 2
attack_range_min = 1
damage = 10
team = 1
hp = 100

//get position in terms of grid
xpos = floor(x/ctrl_grid.grid_size) 
ypos = floor(y/ctrl_grid.grid_size)

//Update position on grid

ctrl_grid.grid_occ[xpos,ypos] = id



event_inherited()