extends Node


func default():
	
	randomize()
	
	# ETHNICITY
	var ethnicity = load("res://Slaves/New Slave/Ethnicity/" + arcology.location + ".gd").new()
	# Returns ethnicty
	print("Ethnicity: " + ethnicity)
	
	# NAME
	var name = load("res://Slaves/New Slave/Names/name.gd").new(ethnicity) # Pass ethnicity into function
	# Returns name
	print("Name: " + name)
	
	#ETHNIC TRAITS
	var traits = load("res://Slaves/New Slave/Ethnicity/ethnic traits.gd").new(ethnicity)  # Pass ethnicity into function
	# Returns ethnic traits
	print("Hair Color: " + traits[0])
	print("Eye Color: " + traits[1])
	print("Skin Color: " + traits[2])
	print("Height: " + traits[3])
	
	# INTELLIGENCE:
	var nq = load("res://Slaves/New Slave/neural quotient.gd").new(100,25) # Pass mean and deviation into function for Gaussian distribution
	# Returns "neural quotient" (Raw brain efficiency)
	print("Neural Quotient: " + nq)
	print()
