extends Node


static func new(ethnicity):
	
	randomize()
	
	var race = null
	var hair_color = null
	var eye_color = null
	var skin_color = null
	var height = null
	
	if ethnicity.match("Chinese"):
		hair_color = "black"
		eye_color = "brown"
		skin_color = "yellow"
		height = str(game.gaussian(155,10)) + " cm"
	
	elif ethnicity.match("Japanese"):
		hair_color = "black"
		eye_color = "brown"
		skin_color = "yellow"
		height = str(game.gaussian(158,10)) + " cm"
	
	elif ethnicity.match("Indian"):
		hair_color = "black"
		eye_color = "brown"
		skin_color = "dark"
		height = str(game.gaussian(152,10)) + " cm"
	
	elif ethnicity.match("Korean"):
		hair_color = "black"
		eye_color = "brown"
		skin_color = "white"
		height = str(game.gaussian(157,10)) + " cm"
	
	# A dictionary would probably make more sense here
	return({
	"hair_color":hair_color,
	"eye_color":eye_color,
	"skin_color":skin_color,
	"height":height
	})
	