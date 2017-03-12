/// @description Insert description here
// You can write your code in this editor

if ctrl_grid.state == "phase"
	{
	var xx = display_get_gui_width()/2
	var yy = display_get_gui_height()/2
	var str = ""
	if ctrl_grid.team == 1
		{
		str = "PLAYER PHASE \nPress Space to continue"
	
		}
	if ctrl_grid.team == 2
		{
		str = "ENEMY PHASE \nPress Space to continue"
	
		}


	draw_set_valign(fa_center)
	draw_set_halign(fa_middle)
	draw_set_font(fnt_phase_change)
	draw_set_color(c_white)
	draw_text(xx,yy,str)

	}
