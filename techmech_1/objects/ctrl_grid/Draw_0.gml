draw_set_alpha(0.3)
//mp_grid_draw(grid)
draw_set_alpha(1)

	
draw_text(0,128,"team: " + string(team))
draw_text(0,144,"current unit: " + string(current_unit))
if state == "unitchosen"
draw_text(0,160,"current unit state: " + string(current_unit.state))
draw_text(0,176,"game state: " + string(state))

//Draw the grid

for(xx = 0 ; xx < grid_width ; xx += 1)
	{
	for(yy = 0 ; yy < grid_height ; yy += 1)
		{
		
		//DEBUG GRID
		var distance = sqrt(power((xx*grid_size-mouse_x),2)+power((yy*grid_size-mouse_y),2))
		var alpha = max(0,1-distance*0.005)
		draw_set_alpha(alpha)
		if alpha>0
			draw_sprite(spr_grid,0,xx*grid_size,yy*grid_size)
		draw_set_alpha(0.3)
		
		
		
		draw_set_font(fnt_debug)
		//draw_text(xx*grid_size,yy*grid_size,string(grid_hit[xx,yy]))
		//draw_text(xx*grid_size,yy*grid_size+6,string(grid_mov[xx,yy]))
		//draw_text(xx*grid_size,yy*grid_size+12,string(grid_ai[xx,yy]))
		//draw_text(xx*grid_size,yy*grid_size+18,string(grid_occ[xx,yy]))
		draw_set_font(fnt_menu)
		draw_text(0,0,state)
		draw_set_alpha(1)
		
		if show_unsafe = true
			{
			
			if grid_unsafe[xx,yy] == 1
				{
				draw_set_alpha(0.3)
				draw_sprite(spr_unsafe_position,0,xx*grid_size,yy*grid_size)
				draw_set_alpha(1)
				}
			}
		
		if team == team_player
			{
			//draw interactable positions
			if state == "ridechosen"
				{
				if current_unit.state == "unoccupying"
					{
					if grid_hit[xx,yy] == 1
						{
						draw_set_alpha(0.3)
						draw_sprite(spr_interact_position,0,xx*grid_size,yy*grid_size)
						draw_set_alpha(1)
						
						}
					}
				}
			
			
			//draw available positions
			if grid_mov[xx,yy] == 1
				{
				if state == "command"
					draw_set_alpha(0.15)
				else if state == "unitchosen" || state == "ridechosen"
					draw_set_alpha(0.3)
				draw_sprite(spr_available_position,0,xx*grid_size,yy*grid_size)
				if state == "ridechosen" || (state == "command" && parent == par_ride)
					{
					if grid_mov[xx+1,yy] == 0 && grid_mov[xx+1,max(0,yy-1)] == 0
						draw_sprite(spr_available_position,0,(xx+1)*grid_size,yy*grid_size)
					if grid_mov[xx,yy+1] == 0 
						draw_sprite(spr_available_position,0,(xx)*grid_size,(yy+1)*grid_size)
					if grid_mov[xx+1,yy+1] == 0 && grid_mov[xx+1,yy] == 0 && grid_mov[xx,yy+1] == 0
						draw_sprite(spr_available_position,0,(xx+1)*grid_size,(yy+1)*grid_size)
					}
				
				}
			//Draw hittable positions
			else if grid_hit[xx,yy] == 1
				{
				if state == "command"
					draw_set_alpha(0.15)
				else if state == "unitchosen" || state == "ridechosen"
					draw_set_alpha(0.3)
				if state == "command"
					{
					if parent == par_unit
						draw_sprite(spr_attackable_position,0,xx*grid_size,yy*grid_size)
					else if parent == par_ride
						if grid_mov[max(0,xx-1),max(0,yy-1)] != 1
							if grid_mov[max(0,xx-1),max(0,yy)] != 1
								if grid_mov[max(0,xx),max(0,yy-1)] != 1
									draw_sprite(spr_attackable_position,0,xx*grid_size,yy*grid_size)
					}
				else if state == "unitchosen" 
					{
					if current_unit.state == "attacking" || current_unit.state == "ready" 
						draw_sprite(spr_attackable_position,0,xx*grid_size,yy*grid_size)
					else if current_unit.state == "covering"
						draw_sprite(spr_interact_position,0,xx*grid_size,yy*grid_size)
					}
				else if state == "ridechosen"
					{
					if current_unit.state == "attacking" || current_unit.state == "ready" 
						{
						if grid_mov[max(0,xx-1),max(0,yy-1)] != 1
							if grid_mov[max(0,xx-1),max(0,yy)] != 1
								if grid_mov[max(0,xx),max(0,yy-1)] != 1
									draw_sprite(spr_attackable_position,0,xx*grid_size,yy*grid_size)
						}
					}
				}	
			}
		}
	}

	
if state == "command"
	{
	//draw_text(mouse_x,mouse_y,object_get_name(parent))
	}

//Show which unit is selected

if current_unit != noone
	{
	if state == "unitchosen"
		{
		if current_unit.state != "moving"
			{		
			draw_sprite(spr_unit_selector,-1,current_unit.x,current_unit.y)
			}
		}
	else if state = "ridechosen"
		{
		if current_unit.state != "moving"
			{		
			draw_sprite(spr_select_2x2,-1,current_unit.x+16,current_unit.y+16)
			}
		}
	}
	
//draw path
if state == "unitchosen"
	{
	if current_unit.state == "ready" && !(mouse_xxx == current_unit.xpos && mouse_yyy == current_unit.ypos)
		{
		var mouse_xx = floor(mouse_x/grid_size)
		var mouse_yy = floor(mouse_y/grid_size)
		if grid_mov[max(0,mouse_xx),max(0,mouse_yy)]  
			{
			if mouse_xx_check!= mouse_xx || mouse_yy_check != mouse_yy	
				{
				mouse_xx_check = mouse_xx
				mouse_yy_check = mouse_yy
				show_path = path_add()
				mp_grid_path(grid,show_path,current_unit.x,current_unit.y,mouse_xx*grid_size + grid_size/2,mouse_yy*grid_size + grid_size/2,false)
				}
			if path_exists(show_path)
				{
				var node_amount = path_get_length(show_path)/8
				for (i=0;i<path_get_number(show_path);i++)
					{
					var xx = path_get_point_x(show_path,i)
					var yy = path_get_point_y(show_path,i)
					var xxnext = path_get_point_x(show_path,i+1)
					var yynext = path_get_point_y(show_path,i+1)
					var xxprev = path_get_point_x(show_path,max(0,i-1))
					var yyprev = path_get_point_y(show_path,max(0,i-1))
					var dir1 = point_direction(xxprev,yyprev,xx,yy)
					var dir2 = point_direction(xx,yy,xxnext,yynext)
					var ind = 0 
					if i == 0
						{
						if dir2 == 0 || dir1 == 360 {ind = 10}
						else if dir2 == 90 {ind = 11}
						else if dir2 == 180 {ind = 12}
						else if dir2 == 270{ind = 13}
						}
					else if i == path_get_number(show_path)-1
						{
						if dir1 == 0 || dir1 == 360 {ind = 6}
						else if dir1 == 270 {ind = 7}
						else if dir1 == 180 {ind = 8}
						else if dir1 == 90 {ind = 9}
						}
					else 
						{
						if (dir1 == 0 || dir1 == 360) && (dir2 == 0 || dir2 == 360){ind = 0}
						else if (dir1 == 90 || dir1 == 270) && (dir2 == 90 || dir2 == 270){ind = 1}
						else if (dir1 == 0 || dir2 == 360) && (dir2 == 90){ind = 2}
						else if (dir1 == 270) && (dir2 == 180){ind = 2}
						else if (dir1 == 270) && (dir2 == 0 || dir2 == 360){ind = 3}
						else if (dir1 == 180) && (dir2 == 90){ind = 3}
						else if (dir1 == 90) && (dir2 == 0 || dir2 == 360){ind = 4}
						else if (dir1 == 180) && (dir2 == 270){ind = 4}
						else if (dir1 == 90) && (dir2 == 180){ind = 5}
						else if (dir1 == 0 || dir1 == 360) && (dir2 == 270){ind = 5}
						}
					draw_sprite_ext(spr_arrow,ind,xx,yy,1,1,0,c_white,0.5)
					//draw_text(xx,yy,string(dir1) + " " +string(dir2))
					}
				}
			}
		}
	}
else if state == "ridechosen"
	{
	if current_unit.state == "ready" && !(mouse_xxx == current_unit.xpos && mouse_yyy == current_unit.ypos)
		{		
		//draw square
		draw_sprite(spr_select_2x2,0,(mouse_xxx+1)*grid_size,(mouse_yyy+1)*grid_size)
		
		
		if grid_mov[mouse_xxx,mouse_yyy]  
			{
			if mouse_xx_check!= mouse_xxx || mouse_yy_check != mouse_yyy	
				{
				mouse_xx_check = mouse_xxx
				mouse_yy_check = mouse_yyy
				show_path = path_add()
				mp_grid_path_2x2(grid, 
								show_path, 
								current_unit.x, 
								current_unit.y, 
								mouse_xxx*grid_size+grid_size/2, 
								mouse_yyy*grid_size+grid_size/2, 
								false,
								current_unit.team)
				}
			if path_exists(show_path)
				{
				var node_amount = path_get_length(show_path)/8
				for (i=0;i<path_get_number(show_path);i++)
					{
					var xx = path_get_point_x(show_path,i)
					var yy = path_get_point_y(show_path,i)
					var xxnext = path_get_point_x(show_path,i+1)
					var yynext = path_get_point_y(show_path,i+1)
					var xxprev = path_get_point_x(show_path,max(0,i-1))
					var yyprev = path_get_point_y(show_path,max(0,i-1))
					var dir1 = point_direction(xxprev,yyprev,xx,yy)
					var dir2 = point_direction(xx,yy,xxnext,yynext)
					var ind = 0 
					if i == 0
						{
						if dir2 == 0 || dir1 == 360 {ind = 10}
						else if dir2 == 90 {ind = 11}
						else if dir2 == 180 {ind = 12}
						else if dir2 == 270{ind = 13}
						}
					else if i == path_get_number(show_path)-1
						{
						if dir1 == 0 || dir1 == 360 {ind = 6}
						else if dir1 == 270 {ind = 7}
						else if dir1 == 180 {ind = 8}
						else if dir1 == 90 {ind = 9}
						}
					else 
						{
						if (dir1 == 0 || dir1 == 360) && (dir2 == 0 || dir2 == 360){ind = 0}
						else if (dir1 == 90 || dir1 == 270) && (dir2 == 90 || dir2 == 270){ind = 1}
						else if (dir1 == 0 || dir2 == 360) && (dir2 == 90){ind = 2}
						else if (dir1 == 270) && (dir2 == 180){ind = 2}
						else if (dir1 == 270) && (dir2 == 0 || dir2 == 360){ind = 3}
						else if (dir1 == 180) && (dir2 == 90){ind = 3}
						else if (dir1 == 90) && (dir2 == 0 || dir2 == 360){ind = 4}
						else if (dir1 == 180) && (dir2 == 270){ind = 4}
						else if (dir1 == 90) && (dir2 == 180){ind = 5}
						else if (dir1 == 0 || dir1 == 360) && (dir2 == 270){ind = 5}
						}
					draw_sprite_ext(spr_arrow,ind,xx+16,yy+16,1,1,0,c_white,0.5)
					//draw_text(xx,yy,string(dir1) + " " +string(dir2))
					}
				}
			}
		}
	}
with(par_unit)
	{
	if coverer != noone
		{
		draw_set_color(c_green)
		draw_line(x,y,coverer.x,coverer.y)
		draw_set_color(c_white)
		}
	}
	



