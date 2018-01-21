extends Node


func gaussian(mean, deviation):

	randomize()

	var x1 = null
	var x2 = null
	var w = null

	while true:

		x1 = rand_range(0, 2) - 1
		x2 = rand_range(0, 2) - 1
		w = x1*x1 + x2*x2

		if 0 < w && w < 1:
			break

	w = sqrt(-2 * log(w)/w)

	return floor(mean + deviation * x1 * w)