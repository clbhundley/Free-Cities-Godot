extends Node


func new(ethnicity):
	
	randomize()
	
	var names = get_node(ethnicity)

	var roll1 = floor(rand_range(0,names.first_names.size()))
	var roll2 = floor(rand_range(0,names.last_names.size()))
	
	return(names.first_names[roll1] + " " + names.last_names[roll2])
