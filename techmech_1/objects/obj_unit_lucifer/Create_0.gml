battle_object = obj_unit_default_4_battle

//adjust the sprite position to match the grid

sprite_set_offset(sprite_index,16,16)
x+=16
y+=16

//Set sprites
image_speed = 0.5
sprite_idle = spr_abel_idle
sprite_run_right = spr_abel_run_right
sprite_run_left = spr_abel_run_left
sprite_run_up = spr_abel_run_up
sprite_run_down = spr_abel_run_down

//Set variables

path = path_add()
state = "wait"
move_range = 8
attack_range_max = 2
attack_range_min = 2
damage = 30
team = 1


//get position in terms of grid
xpos = floor(x/ctrl_grid.grid_size) 
ypos = floor(y/ctrl_grid.grid_size)

//Update position on grid
ctrl_grid.grid_occ[xpos,ypos] = id

//Stats
hp = 30
attack = 20
defense = 7
spd = 15
finesse = 15
tech = 5

event_inherited()