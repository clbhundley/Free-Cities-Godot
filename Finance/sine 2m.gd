extends Node

var sin_const = 0.01

func sine(theta):
	return rad2deg(sin(theta))

var cycle = 120
var amplitude = game.gaussian(2,3)*sin_const
func frame():
	var frame
	var theta
	if cycle > 0:
		cycle -= 1
		frame = 120 - cycle
		theta = frame * 3
		return sine(theta)*amplitude
	else:
		amplitude = game.gaussian(2,3)*sin_const
		cycle = 120
		cycle -= 1
		frame = 120 - cycle
		theta = frame * 3
		return sine(theta)*amplitude
