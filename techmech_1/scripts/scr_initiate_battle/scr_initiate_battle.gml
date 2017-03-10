var attacker = argument0
var defender = argument1
var cover = argument0

//set objects
ctrl_battle.attacker = attacker
ctrl_battle.defender = defender

//calculate damage of attacker
ctrl_battle.attacker_damage = (attacker.attack - defender.defense)

//calculate damage of defender
ctrl_battle.defender_damage = (defender.attack - attacker.defense)

//calculate damage of coverer 
if cover != noone
	{
	ctrl_battle.cover_damage = (cover.attack - defender.defense)
	}
	
//return the hps
ctrl_battle.attacker_maxhp = attacker.maxhp
ctrl_battle.defender_maxhp = defender.maxhp

ctrl_battle.attacker_hp = attacker.hp
ctrl_battle.defender_hp = defender.hp

//return the objects
ctrl_battle.attacker_object = attacker.battle_object
ctrl_battle.defender_object = defender.battle_object
ctrl_battle.cover_object = defender.battle_object

//set camera to focus on target
ctrl_display.transitioning = true
ctrl_display.targetx = attacker.x
ctrl_display.targety = attacker.y

//tell if its players turn
if team == team_player
	{
	ctrl_battle.playerturn = true
	}
else
	{
	ctrl_battle.playerturn = false
	}

//room_goto(rm_simulate_battle)

