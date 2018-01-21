extends Node

var names = load("res://Slaves/New Slave/Names/names.tscn").instance()
var ethnicity = null
var name = null
var skin_color = null
var hair_color = null
var eye_color = null
var height = null
var nq = null


func default():
	
	# ETHNICITY
	ethnicity = load("res://Slaves/New Slave/ethnicity.gd").new()
	# Returns ethnicty
	print(ethnicity)
	
	# NAME
	name = names.new(ethnicity)
	# Returns name
	
	#ETHNIC TRAITS
	var traits = load("res://Slaves/New Slave/ethnic traits.gd").new(ethnicity)  # Pass ethnicity into function
	# Returns ethnic traits
	skin_color = traits["skin_color"]
	hair_color = traits["hair_color"]
	eye_color = traits["eye_color"]
	height = traits["height"]
	
	# INTELLIGENCE:
	nq = load("res://Slaves/New Slave/neural quotient.gd").new(100,25) # Pass mean and deviation into function for Gaussian distribution
	# Returns "neural quotient" (Raw brain efficiency)