var x1 = argument0
var y1 = argument1
var x2 = argument2
var y2 = argument3
var min_range = argument4
var max_range = argument5

if (abs(x1-x2)+ abs(y1-y2) <= max_range) && (abs(x1-x2)+ abs(y1-y2) >= min_range)
	return true
else 
	return false
