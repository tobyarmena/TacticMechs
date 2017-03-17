if abs(x-obj_camera_anchor.x) >= 0.5
	{
	x+= (obj_camera_anchor.x-x)/4
	}
	
if abs(y-obj_camera_anchor.y) >= 0.5
	{
	y+= (obj_camera_anchor.y-y)/4
	}
x = clamp(x,camera_get_view_width(ctrl_display.camera)/2,room_width-camera_get_view_width(ctrl_display.camera)/2)
y = clamp(y,camera_get_view_width(ctrl_display.camera)/2,room_width-camera_get_view_width(ctrl_display.camera)/2)