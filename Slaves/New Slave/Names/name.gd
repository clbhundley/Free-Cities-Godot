extends Node


static func new(ethnicity):
	
	var wew = load("res://Slaves/New Slave/Names/" + ethnicity + ".gd").new()
	
	return(wew)

# Place random name selection stript here