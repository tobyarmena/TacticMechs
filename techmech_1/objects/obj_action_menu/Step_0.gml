/// @description Insert description here
// You can write your code in this editor

with(ctrl_grid)
	{
	if current_unit == noone
		with(other)
			instance_destroy()
	else if current_unit.state != "action"
		with(other)
			instance_destroy()
	}