//x = clamp(x,camera_get_view_width(ctrl_display.camera)/2,room_width-camera_get_view_width(ctrl_display.camera)/2)
//y = clamp(y,camera_get_view_width(ctrl_display.camera)/2,room_width-camera_get_view_width(ctrl_display.camera)/2)
//move anchor based on controls

//set keys
var w = keyboard_check(ord("W"))
var a = keyboard_check(ord("A"))
var s = keyboard_check(ord("S"))
var d = keyboard_check(ord("D"))

//set direction
var dir

if w&&d{dir=45}
else if w&&a{dir=135}
else if a&&s{dir=225}
else if s&&d{dir=315}
else if w{dir = 90}
else if a{dir = 180}
else if s{dir = 270}
else if d{dir = 0}

//move in direction
if w||a||s||d
	{
	
	x = clamp(x+lengthdir_x(move_speed,dir),camera_get_view_width(ctrl_display.camera)/2,room_width-camera_get_view_width(ctrl_display.camera)/2)
	y = clamp(y+lengthdir_y(move_speed,dir),camera_get_view_width(ctrl_display.camera)/2,room_width-camera_get_view_width(ctrl_display.camera)/2)
	}




/*
//move anchor
if w
	y-=move_speed
else if s
	y += move_speed

if a
	x-=move_speed
else if d
	x+=move_speed

