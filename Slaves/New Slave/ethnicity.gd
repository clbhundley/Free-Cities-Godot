extends Node


static func new():
	
	if arcology.location.match("Africa"):
		return(africa())
	
	if arcology.location.match("Asia"):
		return(asia())
	
	if arcology.location.match("Europe"):
		return(europe())
	
	if arcology.location.match("Middle East"):
		return(middle_east())
	
	if arcology.location.match("North America"):
		return(north_america())
	
	if arcology.location.match("South America"):
		return(south_america())


static func africa():
	
	randomize()
	
	var ethnicity = null
	
	var roll = floor(rand_range(0,4))
	
	if roll == 0:
		ethnicity = "Arabic"
	
	elif roll == 1:
		ethnicity = "Ethiopian"
	
	elif roll == 2:
		ethnicity = "Egyptian"
	
	elif roll == 3:
		ethnicity = "test"
	
	return(ethnicity)


static func asia():
	
	randomize()
	
	var ethnicity = null
	
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


func australia():
	
	randomize()
	
	var ethnicity = null
	
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


func europe():
	
	randomize()
	
	var ethnicity = null
	
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


func middle_east():
	
	randomize()
	
	var ethnicity = null
	
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


func north_america():
	
	randomize()
	
	var ethnicity = null
	
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


func south_america():
	
	randomize()
	
	var ethnicity = null
	
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
