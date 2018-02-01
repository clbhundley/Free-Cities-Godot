extends Node

var ethnicity = null
var name = null
var skin_color = null
var hair_color = null
var eye_color = null
var height = null
var nq = null


func default():
	
	# ETHNICITY
	ethnicity = preload("ethnicity.gd").new()
	
	# NAME
	name = preload("Names/names.tscn").instance().new(ethnicity)
	
	#ETHNIC TRAITS
	var traits = preload("ethnic traits.gd").new(ethnicity)
	skin_color = traits["skin_color"]
#	hair_color = traits["hair_color"]
	hair_color = preload("hair color.gd").new(ethnicity)
	eye_color = traits["eye_color"]
	height = traits["height"]
	
	# INTELLIGENCE:
	nq = preload("neural quotient.gd").new(100,25)




func add_slave_to(list):
	list[name] = {
	"Ethnicity":ethnicity,
	"Skin Color":skin_color,
	"Hair Color":hair_color,
	"Eye Color":eye_color,
	"Height":height,
	"Intelligence":nq
	}
