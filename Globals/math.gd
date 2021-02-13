extends Node

func gaussian(mean,deviation):
	randomize()
	var x1
	var x2
	var w
	while true:
		x1 = rand_range(0,2) - 1
		x2 = rand_range(0,2) - 1
		w = x1 * x1 + x2 * x2
		if 0 < w and w < 1:
			break
	w = sqrt(-2 * log(w) / w)
	return floor(mean + deviation * x1 * w)

func random_split_2(value):
	var theta_1 = clamp(gaussian(180,55),0,360)
	var theta_2 = 360 - theta_1
	var arc_1 = theta_1/360
	var arc_2 = theta_2/360
	return [value*arc_1,value*arc_2]
	
func random_split_3(value):
	var theta_1 = clamp(gaussian(120,45),0,360)
	var theta_2 = clamp(gaussian(240,45),theta_1,360) - theta_1
	var theta_3 = 360 - theta_2 - theta_1
	var arc_1 = theta_1/360
	var arc_2 = theta_2/360
	var arc_3 = theta_3/360
	return [value*arc_1,value*arc_2,value*arc_3]

func time_remaining(current_time,total_time):
	var _sec = total_time - current_time
	var _min = int(_sec/60)
	var _hr = int(_min/60)
	_hr = int(_min/60)
	_min = int(_sec/60)
	return str(_hr, ":", _min-_hr*60, ":", _sec-_min*60)

#var RNG = RandomNumberGenerator.new()
#func rng():
#	for i in 300:
#		RNG.randomize()
#		var current_seed = RNG.get_seed() 
#		if sign(current_seed) == -1:
#			print(" ",current_seed)
#		else:
#			print("  ",current_seed)
