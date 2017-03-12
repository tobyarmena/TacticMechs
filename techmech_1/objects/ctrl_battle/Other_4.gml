if room == rm_simulate_battle
	{
	
	state = "attack"

	return_room = room_1

	next_action = false
	hit = false
	hp_updated = true
	
	hp_updated = false
	alarm[0] = 30
	
	if playerturn == true
		{
		instance_create_layer(176,623,"Instances",attacker_object)
		instance_create_layer(844,623,"Instances",defender_object)
		with(defender_object)
			{
			image_xscale = -1
			}
		}
	else
		{
		instance_create_layer(176,623,"Instances",defender_object)
		instance_create_layer(844,623,"Instances",attacker_object)
		with(attacker_object)
			{
			image_xscale = -1
			}
		}
	}
if room == return_room
	{
	if hp_updated == false
		{
		hp_updated = true
		
		attacker.hp = attacker_hp
		defender.hp = defender_hp
		
		if attacker_hp <= 0
			scr_kill(attacker)
		if defender_hp <= 0
			scr_kill(defender)
		
		}
	
	}