//initialize grid
grid_size = 32
grid_width = room_width/grid_size
grid_height = room_height/grid_size


//initialize grids
grid = mp_grid_create(0, 0, grid_width, grid_height, grid_size, grid_size);
grid2 = mp_grid_create(0, 0, grid_width, grid_height, grid_size, grid_size);

for (xx = 0; xx < grid_width;xx+=1)
	{
	for (yy = 0; yy < grid_height;yy+=1)
		{
		grid_occ[xx,yy] = noone
		grid_ter[xx,yy] = ""
		grid_mov[xx,yy] = 0
		grid_hit[xx,yy] = 0
		grid_ai[xx,yy] = 0
		grid_unsafe[xx,yy] = 0
		}
	}
	
//make all walls obstacles
mp_grid_add_instances(grid,obj_wall,false)

//Initialize states
state = "command"

//Initialize variables
current_unit = noone
grid_updated = false
mouse_xx_check = 0
mouse_yy_check = 0
turn_count = 1
team = 2
phase_begin = true
wait_count = 0
action_complete = false
draw_set_font(fnt_menu)
temp_x = 0
temp_y = 0
parent = noone
inst_check = noone
team_player = 1
show_unsafe = false
selected = noone


//Initialize team list
team0 = ds_list_create()
team1 = ds_list_create()
team2 = ds_list_create()








