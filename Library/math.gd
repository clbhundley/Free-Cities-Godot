extends Node

func gaussian(mean,deviation):
	randomize()
	var x1
	var x2
	var w
	while true:
		x1 = rand_range(0,2)-1
		x2 = rand_range(0,2)-1
		w = x1*x1+x2*x2
		if 0 < w and w < 1:
			break
	w = sqrt(-2*log(w)/w)
	return floor(mean+deviation*x1*w)

func time_remaining(current_time,total_time):
	var _sec = total_time-current_time
	var _min = int(_sec/60)
	var _hr = int(_min/60)
	_hr = int(_min/60)
	_min = int(_sec/60)
	return str(_hr,":",_min-_hr*60,":",_sec-_min*60)
