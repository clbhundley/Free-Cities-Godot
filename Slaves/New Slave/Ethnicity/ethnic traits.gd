extends Node


static func new(ethnicity):
	
	var haircolor = null
	var eyecolor = null
	var skincolor = null
	var height = null
	
	if ethnicity.match("Chinese"):
		haircolor = "black"
		eyecolor = "brown"
		skincolor = "yellow"
		height = str(globals.gaussian(155,10)) + " cm"
	
	elif ethnicity.match("Japanese"):
		haircolor = "black"
		eyecolor = "brown"
		skincolor = "yellow"
		height = str(globals.gaussian(158,10)) + " cm"
	
	elif ethnicity.match("Indian"):
		haircolor = "black"
		eyecolor = "brown"
		skincolor = "dark"
		height = str(globals.gaussian(152,10)) + " cm"
	
	elif ethnicity.match("Korean"):
		haircolor = "black"
		eyecolor = "brown"
		skincolor = "white"
		height = str(globals.gaussian(157,10)) + " cm"
	
	# A dictionary would probably make more sense here
	return([haircolor,eyecolor,skincolor,height])
	