/// @description Insert description here
// You can write your code in this editor

if transitioning == true
	{
	draw_set_color(c_white)
	draw_set_alpha(screen_alpha)
	var x1 = camera_get_view_x(camera)
	var y1 = camera_get_view_y(camera)
	var x2 = x1+camera_get_view_width(camera)
	var y2 = y1+camera_get_view_height(camera)
	draw_rectangle(x1,y1,x2,y2,false)
	draw_set_alpha(1)
	
	}