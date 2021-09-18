extends Node

var sin_const = 0.01

func sine(theta):
	return rad2deg(sin(theta))

var cycle = 60
var amplitude = game.gaussian(1,4)*sin_const
func frame():
	var frame
	var theta
	if cycle > 0:
		cycle -= 1
		frame = 60 - cycle
		theta = frame * 6
		return sine(theta)*amplitude
	else:
		amplitude = game.gaussian(1,4)*sin_const
		cycle = 60
		cycle -= 1
		frame = 60 - cycle
		theta = frame * 6
		return sine(theta)*amplitude
