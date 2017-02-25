/// @description Insert description here
// You can write your code in this editor

for (i = 0 ; i < array_height_2d(option) ; i ++)
	{
	var spacing = 4
	
	var x1 = startx
	var y1 = starty + (box_height + spacing*2)*(i)
	
	var x2 = startx + box_width + spacing*2
	var y2 = starty + (box_height + spacing*2)*(i+1)
	
	
	//execute action if pressed
	
	if mouse_x > x1 && mouse_x < x2 && mouse_y > y1 && mouse_y < y2
		{
		draw_set_alpha(0.7)
		if mouse_check_button_pressed(mb_left)
			{
			script_execute(option[i,1])
			}
		}
	else
		{
		draw_set_alpha(0.3)
		}
						
	//draw the box and the text
						
	
	draw_set_color(c_gray)
	draw_rectangle(x1,y1,x2,y2,false)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_font(fnt_menu)
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_text(x1+spacing,y1+spacing,option[i,0])
	
	}