if coverer == noone
	{
	with(attacker_object)
		{
		state = "attacking"
		sprite_index = spr_attack
		}
	with(defender_object)
		{
		state = "defending"
		}
	}
else
	{
	with(coverer_object)
		{
		state = "attacking"
		sprite_index = spr_attack
		}
	with(attacker_object)
		{
		state = "defending"
		}
	with(defender_object)
		{
		state = "idle"
		}
	}