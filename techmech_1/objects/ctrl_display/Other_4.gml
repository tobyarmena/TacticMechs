/// @description Insert description here
// You can write your code in this editor
show_debug_overlay(true)

camera = camera_create_view(0, 0, 1024, 768, 0, -1, -1, -1, 32, 32);
view_set_camera(0, camera);

zoom_level = 1;

default_zoom_width = camera_get_view_width(view_camera[0]);
default_zoom_height = camera_get_view_height(view_camera[0]);


transitioning = false
unmovable = false
targetx = 0
targety = 0

screen_alpha = 0 


if room == rm_simulate_battle
	{
	zoom_level = 1
	
	obj_camera_anchor.x = room_width/2
	obj_camera_anchor.y = room_height/2
	obj_camera.x = room_width/2
	obj_camera.y = room_height/2
	var view_w = camera_get_view_width(view_camera[0]);
	var view_h = camera_get_view_height(view_camera[0]);
	camera_set_view_size(view_camera[0], view_w*3, view_h*3);
	}
else if room == ctrl_battle.return_room
	{
	zoom_level = 1//temp_zoom_level
	var view_w = camera_get_view_width(view_camera[0]);
	var view_h = camera_get_view_height(view_camera[0]);
	camera_set_view_size(view_camera[0], view_w*0.1, view_h*0.1);
	}