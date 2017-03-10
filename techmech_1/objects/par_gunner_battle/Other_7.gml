/// @description Insert description here
// You can write your code in this editor

if sprite_index = spr_attack
	{
	ctrl_battle.next_action = true
	}
else if sprite_index = spr_hit
	{
	sprite_index = spr_idle
	}
else if sprite_index = spr_die
	{
	image_index = -1
	image_speed = 0
	if !ctrl_battle.alarm[1] 
		ctrl_battle.alarm[1] = 10
	}