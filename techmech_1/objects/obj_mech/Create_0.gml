image_alpha = 0.4

//adjust the sprite position to match the grid

sprite_set_offset(sprite_index,16,16)
x+=16
y+=16

//Set sprites

sprite_idle = spr_mech
sprite_run_right = spr_mech
sprite_run_left = spr_mech
sprite_run_up = spr_mech
sprite_run_down = spr_mech

//Set variables

path = path_add()
path1 = path_add()
path2 = path_add()
path3 = path_add()
path4 = path_add()
state = "ready"
move_range = 4
attack_range_max = 2
attack_range_min = 1
damage = 10
team = 1
hp = 100

//get position in terms of grid
xpos = floor(x/ctrl_grid.grid_size) 
x2pos = xpos+1
ypos = floor(y/ctrl_grid.grid_size)
y2pos = ypos+1

//Update position on grid

ctrl_grid.grid_occ[xpos,ypos] = id
ctrl_grid.grid_occ[x2pos,ypos] = id
ctrl_grid.grid_occ[xpos,y2pos] = id
ctrl_grid.grid_occ[x2pos,y2pos] = id



event_inherited()