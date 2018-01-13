extends Node

static func new():
	
	var ethnicity = null
	
	randomize()
	
	var roll = floor(rand_range(0,4))
	
	if roll == 0:
		ethnicity = "Korean"
		
	elif roll == 1:
		ethnicity = "Japanese"
		
	elif roll == 2:
		ethnicity = "Chinese"
	
	elif roll == 3:
		ethnicity = "Indian"

	return(ethnicity)
	