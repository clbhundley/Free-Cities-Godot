extends Node

var sin_const = 0.01

func sine(theta):
	return rad2deg(sin(theta))

var cycle = 360
var amplitude = game.gaussian(6,2)*sin_const
func frame():
	var frame
	var theta
	if cycle > 0:
		cycle -= 1
		frame = 360 - cycle
		theta = frame
		return sine(theta)*amplitude
	else:
		amplitude = game.gaussian(6,2)*sin_const
		cycle = 360
		cycle -= 1
		frame = 360 - cycle
		theta = frame
		return sine(theta)*amplitude
