extends Node

static func new():
	
	var first = [
	"Hikari",
	"Ito",
	"Azumi",
	]
	
	var last = [
	"Sato",
	"Nakamura",
	"Mori",
	]
	
	
	# Use setget or similar method to place this in name.gd
	randomize()
	var roll1 = floor(rand_range(0,first.size()))
	
	randomize()
	var roll2 = floor(rand_range(0,last.size()))
	
	return(first[roll1] + " " + last[roll2])