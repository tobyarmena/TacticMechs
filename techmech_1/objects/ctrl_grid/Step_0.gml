//store mouses position in terms of the grid
mouse_xxx = max(0,floor(mouse_x/grid_size))
mouse_yyy = max(0,floor(mouse_y/grid_size))



//Code for controlling selected unit

if state == "unitchosen" && team == team_player
	{
	if mouse_check_button_pressed(mb_left) && current_unit.state == "ready"
		{	
		//move selected unit
		if mouse_xxx == current_unit.xpos && mouse_yyy == current_unit.ypos
			{
			scr_reset_movhit()
			
			scr_update_hit_grid()
			with(current_unit)
				{
				//empty movable position grid
				path_position = 0 
				state = "action"
				other.grid_updated = false
				other.action_complete = true
				}
			}
		else if grid_mov[mouse_xxx,mouse_yyy] == 1 && grid_occ[mouse_xxx,mouse_yyy] == noone
			{
			current_unit.state = "moving"
			scr_move(current_unit,mouse_xxx,mouse_yyy)
			scr_reset_movhit()
			}
		}
		
	//This is what happens when unit is done moving
	with(current_unit)
		{
		if path_exists(path)
			if path_position == 1 
				{
				if state == "moving"
					{
					path_position = 0 
					state = "action"
				
					other.grid_updated = false
					other.action_complete = true
					scr_update_hit_grid()
					scr_update_unsafe_grid()
					}
				else if state == "entering"
					{
					state = "piloting"
					team = 0
					ds_list_delete(ctrl_grid.team1,ds_list_find_index(ctrl_grid.team1,id))
					ds_list_add(ctrl_grid.team1,other.selected)
					other.selected.team = 1
					other.selected.state = "ready"
					x = -32
					y = -32
					
					path_position = 0 
					other.state = "command"
					other.current_unit = noone
					other.grid_updated = false
					other.action_complete = true
					exit;
					}
				}
		}
		
	//choose an action to perform after movement
	if current_unit.state == "action"
		{
		obj_camera_anchor.x = current_unit.x
		obj_camera_anchor.y = current_unit.y
		if !instance_exists(obj_action_menu)
			{
			instance_create_layer(current_unit.x-64,current_unit.y-16,"GUI",obj_action_menu)
			}
		}
		
	//Attack
	if current_unit.state == "attacking"
		{
		if mouse_check_button_pressed(mb_right)
			{
			current_unit.state = "action"
			}
		if mouse_check_button_pressed(mb_left)
			{
			if grid_hit[mouse_xxx,mouse_yyy]
				{
				if grid_occ[mouse_xxx,mouse_yyy] != noone
					{
					var target = grid_occ[mouse_xxx,mouse_yyy]
					if target.team != current_unit.team
						{
						scr_initiate_battle(current_unit,target)
						/*
						target.hp -= 10
						current_unit.state = "wait"
						state = "command"
						current_unit = noone
						grid_updated = false
						action_complete = true
						exit;
						*/
						}
					}
				}
			}
		}
		
	//Occupy a vehicle
	if current_unit.state = "occupying"
		{
		if mouse_check_button_pressed(mb_right)
			{
			current_unit.state = "action"
			}
		
		var target = grid_occ[mouse_xxx,mouse_yyy]
		
		if target != noone
			{
			if object_get_parent(target.object_index) == par_ride
				{
				for(xx = 0 ; xx < 2 ; xx ++)
					for(yy = 0; yy < 2 ; yy ++)
						{
						var xxx = target.xpos+xx
						var yyy = target.ypos+yy
						if scr_check_in_range(xxx,yyy,current_unit.xpos,current_unit.ypos,1,1)
							{
							if instance_nearest(current_unit.x,current_unit.y,par_ride) == target
								{
								selected = target
								if mouse_check_button_pressed(mb_left)
									{
									selected.pilot = current_unit
									current_unit.state = "entering"
									scr_move_scene(current_unit,xxx,yyy)
									break;
									}
								}
							}
						}
				}
			} 
		}
		
	
		
	//Cancel move
	if mouse_check_button_pressed(mb_right)
		{
		if current_unit.state == "action" || current_unit.state == "ready" 
			{
			grid_occ[current_unit.xpos,current_unit.ypos] = noone
			current_unit.x = temp_x
			current_unit.y = temp_y
			current_unit.xpos = floor(current_unit.x/grid_size)
			current_unit.ypos = floor(current_unit.y/grid_size)
			grid_occ[current_unit.xpos,current_unit.ypos] = current_unit.id
			
			state = "command"
			current_unit.state = "ready"
			current_unit.path_position = 0
			current_unit = noone
			
			grid_updated = false
			action_complete = true
			
			
			
			exit;
			}
		
		}
	
	}
	
//Code for controlling ride 

if state == "ridechosen" && team == team_player
	{
	if mouse_check_button_pressed(mb_left) && current_unit.state == "ready"
		{
		//do an action without moving
		if mouse_xxx == current_unit.xpos && mouse_yyy == current_unit.ypos
			{
			//empty movable position grid
			scr_reset_movhit()
			
			scr_update_hit_grid()
			with(current_unit)
				{
				path_position = 0 
				state = "action"
				other.grid_updated = false
				other.action_complete = true
				}
			}
		//move ride
		else if grid_mov[mouse_xxx,mouse_yyy] == 1
			{
			current_unit.state = "moving"
			scr_move_ride(current_unit,mouse_xxx,mouse_yyy,current_unit.team)
			
			//empty movable position grid
			for (xx = 0 ; xx <= grid_width ; xx++)
				for (yy = 0 ; yy <=  grid_height ; yy++)
					{
					grid_mov[xx,yy] = 0
					grid_hit[xx,yy] = 0
					}
			}
		}
		
	//This is what happens when unit is done moving
	with(current_unit)
		{
		if path_exists(path)
			if path_position == 1
				{
				path_position = 0 
				state = "action"
				other.grid_updated = false
				other.action_complete = true
				scr_update_hit_grid()
				}
		}
		
	//choose an action to perform after movement
	
	if current_unit.state == "action"
		{
		if !instance_exists(obj_action_menu)
			{
			instance_create_layer(current_unit.x-64,current_unit.y-16,"GUI",obj_action_menu)
			
			}
		}
		
	//Attacking
	if current_unit.state = "attacking"
		{
		if mouse_check_button_pressed(mb_right)
			{
			current_unit.state = "action"
			}
		if mouse_check_button_pressed(mb_left)
			{
			
			if grid_hit[mouse_xxx,mouse_yyy] == 1
				{
				if grid_occ[mouse_xxx,mouse_yyy] != noone
					{
					var target = grid_occ[mouse_xxx,mouse_yyy]
					if target.team != current_unit.team
						{
						target.hp -= 10
						grid_occ[mouse_xxx,mouse_yyy].hp -= 10
						current_unit.state = "wait"
						state = "command"
						current_unit = noone
						grid_updated = false
						action_complete = true
						exit;
						}
					}
				}
			} 
		}
		
	//unoccupy a vehicle
	if current_unit.state == "unoccupying"
		{
		var posx 
		var posy 
		scr_update_hit_range(1,1,true)
		if mouse_check_button_pressed(mb_left)
			{
			posx = mouse_xxx
			posy = mouse_yyy
			var initialx = -4
			var initialy = -4
			for(xx = current_unit.xpos;xx <= current_unit.xpos+1;xx++)
				for (yy = current_unit.ypos;yy <= current_unit.ypos+1;yy++)
					{
					if scr_check_in_range(xx,yy,posx,posy,1,1)
						{
						initialx = xx
						initialy = yy
						
						current_unit.pilot.x = initialx*grid_size+grid_size/2
						current_unit.pilot.y = initialy*grid_size+grid_size/2
						current_unit.pilot.state = "moving"
						scr_move_scene(current_unit.pilot,posx,posy)
						current_unit.pilot.xpos = posx
						current_unit.pilot.ypos = posy
						grid_occ[posx,posy] = current_unit.pilot
						}
					}
			
			
			}
		if current_unit.pilot.state == "moving" && current_unit.pilot.path_position ==1
				{
				current_unit.pilot.path_position = 0
				
				current_unit.pilot.state = "wait"	
				current_unit.state = "unoccupied"
				current_unit.pilot.team = 1
				current_unit.team = 0
				ds_list_add(team1,current_unit.pilot)
				ds_list_delete(team1,ds_list_find_index(team1,current_unit))
						
				current_unit.pilot = noone
						

				state = "command"
				current_unit = noone
				grid_updated = false
				action_complete = true
				}
		}
		
	//Cancel move
	if mouse_check_button_pressed(mb_right)
		{
		if current_unit.state == "action" || current_unit.state == "ready" 
			{
			grid_occ[current_unit.xpos,current_unit.ypos] = noone
			grid_occ[current_unit.xpos+1,current_unit.ypos] = noone
			grid_occ[current_unit.xpos,current_unit.ypos+1] = noone
			grid_occ[current_unit.xpos+1,current_unit.ypos+1] = noone
			current_unit.x = temp_x
			current_unit.y = temp_y
			current_unit.xpos = floor(current_unit.x/grid_size)
			current_unit.ypos = floor(current_unit.y/grid_size)
			grid_occ[current_unit.xpos,current_unit.ypos] = current_unit.id
			grid_occ[current_unit.xpos+1,current_unit.ypos] = current_unit.id
			grid_occ[current_unit.xpos,current_unit.ypos+1] = current_unit.id
			grid_occ[current_unit.xpos+1,current_unit.ypos+1] = current_unit.id
			
			state = "command"
			current_unit.state = "ready"
			current_unit.path_position = 0
			current_unit = noone
			
			grid_updated = false
			action_complete = true
			
			
			
			exit;
			}
		
		}
	}	


//Code for selecting which unit to command

if state == "command" && team == team_player
	{
	//Quick End
	if keyboard_check_pressed(vk_space)
		{
		with(par_unit)
			state = "wait"
		with(par_ride)
			state = "wait"
		exit;
		}
	
		
	if mouse_x >= 0 && mouse_y >= 0 && mouse_x < room_width && mouse_y < room_height //check if mouse is inside room
		{
		if grid_occ[mouse_xxx,mouse_yyy] != noone //check if there is an object of interest under the mouse
			{
			
			//prompt the grid to be updated again if mouse changes positions
			if inst_check != grid_occ[mouse_xxx,mouse_yyy]
				{
				inst_check = grid_occ[mouse_xxx,mouse_yyy]
				grid_updated = false
				}
			
			
			
			//Get the value of the parent
			parent = object_get_parent(grid_occ[mouse_xxx,mouse_yyy].object_index)
			
			//Update the grid to display movement of unit under the cursor
			if grid_updated = false && (grid_occ[mouse_xxx,mouse_yyy].state == "ready" || grid_occ[mouse_xxx,mouse_yyy].team != team_player) && parent == par_unit
				{
				grid_updated = true
				scr_reset_movhit()
				
				with(grid_occ[mouse_xxx,mouse_yyy])
					{
					scr_grid_refresh_team(team)
					for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
						{
						for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
							{
							if mp_grid_path(other.grid,path,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false)
								{	
								if path_get_length(path)/ctrl_grid.grid_size <= move_range
									{
									other.grid_mov[xx,yy] = 1
									//Set hittable positions
										for (xxx = xx-attack_range_max;xxx <= xx+attack_range_max;xxx++)
											for (yyy = yy-attack_range_max;yyy <= yy+attack_range_max;yyy++)
												{
												if abs(xxx-xx)+ abs(yyy-yy) <= attack_range_max
													if abs(xxx-xx)+ abs(yyy-yy) >= attack_range_min
														{
														if xxx>=0 && yyy>=0
															other.grid_hit[xxx,yyy] = 1
														}
												}
									}
								}
							}
						}
					}
				}
				
			//Update the grid to display movement of ride under the cursor
			else if grid_updated = false && (grid_occ[mouse_xxx,mouse_yyy].state == "ready"|| grid_occ[mouse_xxx,mouse_yyy].team != team_player) && parent == par_ride
				{
				grid_updated = true
				//Set movable positions for unit
				scr_reset_movhit()	
				with(grid_occ[mouse_xxx,mouse_yyy])
					{
					scr_grid_refresh_team(team)
					for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
						for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
							{
							if mp_grid_path_2x2(other.grid,path1,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false,team)
								{
								if (other.grid_occ[xx+1,yy+1] == noone || other.grid_occ[xx+1,yy+1] == id) && (other.grid_occ[xx,yy+1] == noone || other.grid_occ[xx,yy+1] == id) && (other.grid_occ[xx+1,yy] == noone || other.grid_occ[xx+1,yy] == id) && (other.grid_occ[xx,yy] == noone || other.grid_occ[xx,yy] == id)
									if path_get_length(path1)/ctrl_grid.grid_size <= move_range
										{
										other.grid_mov[xx,yy] = 1	
										//Set hittable positions
										for (xp = xx; xp <= xx+1;xp++)
											for (yp = yy; yp <= yy+1;yp++)
												for (xxx = xp-attack_range_max;xxx <= xp+attack_range_max;xxx++)
													for (yyy = yp-attack_range_max;yyy <= yp+attack_range_max;yyy++)
														{
														if abs(xxx-xp)+ abs(yyy-yp) <= attack_range_max
															if abs(xxx-xp)+ abs(yyy-yp) >= attack_range_min
																{
																if xxx >= 0 && yyy >=0
																	{
																	other.grid_hit[xxx,yyy] = 1
																	}
																}
														}
												
											
										
										}
								}
								scr_grid_refresh_team(team)
							}
					}
				
				}
			
		
			if mouse_check_button_pressed(mb_left)
				{
				//What happens when you press a unit
				if grid_occ[mouse_xxx,mouse_yyy].state == "ready" && parent == par_unit
					{
					//update current unit and switch game state
					current_unit = grid_occ[mouse_xxx,mouse_yyy]
					state = "unitchosen"
					
					//store position incase player cancels move
					temp_x = current_unit.x
					temp_y = current_unit.y 
					
					//Set movable and hittable positions positions for unit
					scr_reset_movhit()
					with(current_unit)
						{
						scr_grid_refresh()
						for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
							for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
								{
						
								if mp_grid_path(other.grid,path,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false)
									{
									if path_get_length(path)/ctrl_grid.grid_size <= move_range
										{
										other.grid_mov[xx,yy] = 1
										
										//Set hittable positions
										for (xxx = xx-attack_range_max;xxx <= xx+attack_range_max;xxx++)
											for (yyy = yy-attack_range_max;yyy <= yy+attack_range_max;yyy++)
												{
												if scr_check_in_range(xxx,yyy,xx,yy,attack_range_min,attack_range_max)
													{
													if xxx>=0 && yyy>=0
														other.grid_hit[xxx,yyy] = 1
													}
												}
										
										
										}
									}
								}
						}
					
					
					}
				//what happens when you press a ride
				else if grid_occ[mouse_xxx,mouse_yyy].state == "ready" && parent == par_ride
					{
					//update current unit and switch game state
					current_unit = grid_occ[mouse_xxx,mouse_yyy]
					state = "ridechosen"
					
					//store position incase player cancels move
					temp_x = current_unit.x
					temp_y = current_unit.y
					
					//Set movable positions for unit
					scr_reset_movhit()
					with(current_unit)
						{
						scr_grid_refresh()
						for (xx = xpos - move_range;xx <= xpos + move_range;xx++)
							for (yy = ypos - move_range;yy <= ypos + move_range;yy++)
								{
								if mp_grid_path_2x2(other.grid,path1,x,y,xx*other.grid_size+other.grid_size/2,yy*other.grid_size+other.grid_size/2,false,team)
									{
									if (other.grid_occ[xx+1,yy+1] == noone || other.grid_occ[xx+1,yy+1] == id) && (other.grid_occ[xx,yy+1] == noone || other.grid_occ[xx,yy+1] == id) && (other.grid_occ[xx+1,yy] == noone || other.grid_occ[xx+1,yy] == id) && (other.grid_occ[xx,yy] == noone || other.grid_occ[xx,yy] == id)
										{
										if path_get_length(path1)/ctrl_grid.grid_size <= move_range
											{
											other.grid_mov[xx,yy] = 1
													
											//Set hittable positions
											for (xp = xx; xp <= xx+1;xp++)
												for (yp = yy; yp <= yy+1;yp++)
													for (xxx = xp-attack_range_max;xxx <= xp+attack_range_max;xxx++)
														for (yyy = yp-attack_range_max;yyy <= yp+attack_range_max;yyy++)
															{
															if scr_check_in_range(xxx,yyy,xp,yp,attack_range_min,attack_range_max)
																{
																if xxx>= 0 && yyy >= 0
																	other.grid_hit[xxx,yyy] = 1
																}
															}
											}
										}
									}
								}
						}
					}
				
				}
			}
		else
			{
			grid_updated = false
			
			//empty movable position grid
			for (xx = 0 ; xx <= grid_width ; xx++)
				for (yy = 0 ; yy <=  grid_height ; yy++)
					{
					grid_mov[xx,yy] = 0
					grid_hit[xx,yy] = 0
					}
			}
		}
	
	}
	
///Check if a turn has ended

if action_complete == true
	{
	action_complete = false
	wait_count = 0
	if team == 1
		{
		for (i = 0; i < ds_list_size(team1); i++)
			{
			if ds_list_find_value(team1,i).state == "wait"
				{
				wait_count ++
				}
			if wait_count == ds_list_size(team1)
				phase_begin = true
			}
		}
	else if team == 2
		{
		for (i = 0; i < ds_list_size(team2); i++)
			{
			if ds_list_find_value(team2,i).state == "wait"
				{
				wait_count ++
				}
			if wait_count == ds_list_size(team2)
				phase_begin = true
			}
		}
	}
	
	
///Control turn phasing

if phase_begin == true
	{
	scr_update_unsafe_grid()
	phase_begin = false
	
	wait_count = 0
	
	//increase turn count
	if team == 2
		turn_count ++
	
	//switch teams
	if team == 1
		team = 2
	else if team == 2
		team = 1
		
	//reactivate players
	if team == 1
		{
		for (i = 0; i < ds_list_size(team1); i++)
			{
			with(ds_list_find_value(team1,i))
				{
				var par = object_get_parent(id.object_index)
				if par == par_unit
					state = "ready"
				else if par == par_ride
					{
					if pilot != noone
						state = "ready"
					}
				}
			}
		}
	else if team == 2
		{
		for (i = 0; i < ds_list_size(team2); i++)
			{
			with(ds_list_find_value(team2,i))
				{
				state = "ready"
				}
			}
		}
	}
	
	
if keyboard_check(vk_escape)
	game_end()
	
	
// khang nguyen wrote all this code 




///ENEMY AI

if state == "command" && team != team_player
	{
	//choose a random enemy to command
	for (i=0 ; i<ds_list_size(team2) ; i++)
		{
		if ds_list_find_value(team2,i).state == "ready"
			{
			current_unit = ds_list_find_value(team2,i)
			break;
			}
		
		}
	if current_unit != noone
		{
		state = "unitchosen_ai"
		scr_grid_available()
		}
	}
	
//Control chosen Enemy

if state == "unitchosen_ai"
	{
	//choose a random target
	var victim = ds_list_find_value(team1,0)
	if current_unit.state == "ready"
		{
		current_unit.state = "moving"
		scr_ai_follow(victim)	
		}
		
	//This is what happens when unit is done moving
	
	with(current_unit)
		{
		if path_exists(path)
			if path_position == 1
				{
				path_position = 0 
				state = "action"
				other.grid_updated = false
				other.action_complete = true
				scr_update_hit_grid()
				scr_update_unsafe_grid()
				
				}
		}
		
	//Attack if it can
	
	if current_unit.state == "action"
		{
		//check if target is in hit range
		for (xx=0;xx<grid_width;xx++)
			for (yy=0;yy<grid_height;yy++)
				{
				if grid_hit[xx,yy] == 1
					{
					if grid_occ[xx,yy] == victim
						{
						scr_initiate_battle(current_unit,grid_occ[xx,yy])
						break;
						}
					}
				}
		current_unit.state = "wait"
		state = "command"
		current_unit = noone
		grid_updated = false
		action_complete = true
		}
	}
	
//Press Tab to show unsafe positions
if keyboard_check_pressed(vk_tab)
	{
	if show_unsafe = false
		{
		show_unsafe = true
		scr_update_unsafe_grid()
		}
	else 
		{
		show_unsafe = false
		}
	}
	









/*
if mouse_check_button_pressed(mb_left)
	{
	scr_move(obj_unit_default,floor(mouse_x/grid_size),floor(mouse_y/grid_size))
	}