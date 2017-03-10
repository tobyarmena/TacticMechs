/// @description Insert description here
// You can write your code in this editor

if current_unit != noone
	{
	if current_unit.state == "attacking"
		{
		
		
		
		ctrl_display.transitioning = false
		current_unit.state = "wait"
		state = "command"
		current_unit = noone
		grid_updated = false
		action_complete = true
		exit;
		}
	}