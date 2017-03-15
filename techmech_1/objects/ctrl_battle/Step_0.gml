/// @description Insert description here
// You can write your code in this editor

if keyboard_check_pressed(ord("C"))
	{
	if room == room_1
		room_goto(rm_simulate_battle)
	else
		room_goto(room_1)
	}
if state == "cover"
	{
	if hit = true
		{
		hit = false
		attacker_hp -= coverer_damage
		if attacker_hp <= 0
			{
			attacker_object.sprite_index = defender_object.spr_die
			}
		else
			{
			attacker_object.sprite_index = defender_object.spr_hit
			}
		}
	if next_action == true
		{
		next_action = false
		if attacker_hp > 0
			{
			state = "attack"
			attacker_object.state = "attacking"
			defender_object.state = "defending"
			coverer_object.state = "defending"
			defender_object.sprite_index = defender_object.spr_idle
			coverer_object.sprite_index = coverer_object.spr_idle
			attacker_object.sprite_index = attacker_object.spr_attack
			attacker_object.image_index = 0
			defender_object.image_index = 0
			coverer_object.image_index = 0
			}
		else
			{
			state = "idle"
			coverer_object.sprite_index = attacker_object.spr_idle
			}
		}
	}
if state == "attack"
	{
	if hit = true
		{
		hit = false
		defender_hp -= attacker_damage
		if defender_hp <= 0
			{
			defender_object.sprite_index = defender_object.spr_die
			}
		else
			{
			defender_object.sprite_index = defender_object.spr_hit
			}
		}
	if next_action == true
		{
		next_action = false
		if covering == false
			{
			//show_message(string(object_get_name(defender.object_index)))
			if defender_hp > 0 
				{
				state = "defend"
				attacker_object.state = "defending"
				defender_object.state = "attacking"
				attacker_object.sprite_index = attacker_object.spr_idle
				defender_object.sprite_index = defender_object.spr_attack
				attacker_object.image_index = 0
				defender_object.image_index = 0
				}
			else
				{
				state = "idle"
				attacker_object.sprite_index = attacker_object.spr_idle
				}
			}
		else
			{
			state = "done"
			ctrl_display.transitioning = true
			attacker_object.state = "idle"
			defender_object.state = "idle"
			attacker_object.sprite_index = attacker_object.spr_idle
			defender_object.sprite_index = defender_object.spr_idle
			}
		}
	}
else if state == "defend"
	{
	if hit == true
		{
		hit = false
		attacker_hp -= defender_damage
		if attacker_hp <= 0
			{
			attacker_object.sprite_index = attacker_object.spr_die
			}
		else
			{
			attacker_object.sprite_index = attacker_object.spr_hit
			}
		}
	if next_action == true
		{
		next_action = false
		if attacker_hp>0
			{
			state = "done"
			ctrl_display.transitioning = true
			attacker_object.state = "idle"
			defender_object.state = "idle"
			attacker_object.sprite_index = attacker_object.spr_idle
			defender_object.sprite_index = defender_object.spr_idle
			}
		else 
			{
			state = "idle"
			defender_object.sprite_index = attacker_object.spr_idle
			}
		
		}
	}
else if state == "done"
	{
	
	}
	
