/// @description Insert description here
// You can write your code in this editor

//draw_text(x+32,y,string(direction))

//draw sprite

if state == "wait" || state == "unoccupied"
	{
	draw_sprite_stretched_ext(sprite_index,image_index,x-16,y-16,sprite_width,sprite_height,c_gray,1)
	}
else
	{
	if state == "moving"
		{
		
		image_speed = 6
		var sprite = sprite_run_right
		if direction == 90 
			sprite = sprite_run_up
		else if direction == 180
			sprite = sprite_run_left
		else if direction == 270
			sprite = sprite_run_down
		else if direction == 0 || direction == 360
			sprite = sprite_run_right
		draw_sprite_stretched_ext(sprite,image_index,x-16,y-16,sprite_width,sprite_height,c_white,1)
		}
	else
		{
		image_speed = 3
		draw_sprite_stretched_ext(sprite_index,image_index,x-16,y-16,sprite_width,sprite_height,c_white,1)
		}
	}


//displaye state
draw_text(x-10,y-24,state)
draw_text(x-10,y-36,pilot)

if state != "moving"
	{
	//draw hp bar
	var percent = hp/maxhp
	var length = 48
	var x1 = x+16-length/2
	var y1 = y+50
	var x2 = x1 + length
	var x2_hp = x1 + length*percent
	var y2 =  y+56


	draw_set_alpha(0.5)
	draw_set_color(c_green)
	draw_rectangle(x1,y1,max(x1,x2_hp),y2,false)
	if hp != maxhp
		{
		draw_set_color(c_red)
		draw_rectangle(max(x1,x2_hp),y1,x2,y2,false)
		}

	draw_set_alpha(1)

	draw_set_color(c_white)
	}