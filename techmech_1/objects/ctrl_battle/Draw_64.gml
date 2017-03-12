/// @description Insert description here
// You can write your code in this editor

if room = rm_simulate_battle
	{
	var bar_height = 32
	var bar_width = 256

	var b1_x1 = 32
	var b1_y1 = 32
	var b1_x2 = b1_x1+bar_width
	var b1_y2 = b1_y1+bar_height
	if playerturn == true
		var ratio_attack = attacker_hp/attacker_maxhp
	else
		var ratio_attack = defender_hp/defender_maxhp
	var b1_xx2 = b1_x1+bar_width*ratio_attack
	
	if playerturn == true
		var ratio_defend = defender_hp/defender_maxhp
	else
		var ratio_defend = attacker_hp/attacker_maxhp
	var b2_y1 = 32
	var b2_x2 = display_get_gui_width()-32
	var b2_y2 = b2_y1+bar_height
	var b2_x1 = b2_x2-bar_width
	var b2_xx2 = b2_x1+bar_width*ratio_defend

	draw_set_color(c_gray)
	draw_set_alpha(0.5)
	draw_rectangle(max(b1_x1,b1_xx2),b1_y1,b1_x2,b1_y2,false)
	draw_rectangle(max(b2_x1,b2_xx2),b2_y1,b2_x2,b2_y2,false)
	
	draw_set_color(c_red)
	if ratio_attack > 0
		draw_rectangle(b1_x1,b1_y1,max(b1_x1,b1_xx2),b1_y2,false)
	if ratio_defend > 0
		draw_rectangle(b2_x1,b2_y1,max(b2_x1,b2_xx2),b2_y2,false)
	
	
	draw_set_color(c_white)
	draw_set_alpha(1)
	}
	
draw_text(126,128,string(ctrl_display.transitioning))


