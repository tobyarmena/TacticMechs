if transitioning == true 
	{
	if room == ctrl_battle.return_room
		{
		obj_camera_anchor.x = targetx
		obj_camera_anchor.y = targety
		if abs(obj_camera.x - obj_camera.x) < 0.5
			{
			screen_alpha += 0.1
			temp_zoom_level = zoom_level
			zoom_level = 0.1
			}
		}
	else if room == rm_simulate_battle
		{
		screen_alpha += 0.1
		zoom_level = 5
		}
	}





//Move the zoom level based on mouse scrolling. Clamp the value so stuff doesn't get too silly.
zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.1, 5);

//Get current size
var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

//Set the rate of interpolation
var rate = 0.2;

//Get new sizes by interpolating current and target zoomed size
var new_w = lerp(view_w, zoom_level * default_zoom_width, rate);
var new_h = lerp(view_h, zoom_level * default_zoom_height, rate);

//Apply the new size
camera_set_view_size(view_camera[0], new_w, new_h);

var shift_x = obj_camera.x - new_w/2
var shift_y = obj_camera.y - new_h/2

//Update the view position
camera_set_view_pos(view_camera[0],shift_x, shift_y)


//Changing rooms
//follow up code to attack initiation
if transitioning == true && screen_alpha = 1
	{
	if room == ctrl_battle.return_room
		room_goto(rm_simulate_battle)
	else if room == rm_simulate_battle
		room_goto(ctrl_battle.return_room)
	}

