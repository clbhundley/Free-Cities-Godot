extends Node

static func new(X,Y):
	var nq = null
	var roll = (game.gaussian(X,Y))
	
	if roll < 25:
		nq = "Vegetable (" + str(roll) + ")"
		
	elif roll >= 25 and roll < 50:
		nq = "Handicapped (" + str(roll) + ")"
		
	elif roll >= 50 and roll < 75:
		nq = "Slow (" + str(roll) + ")"
		
	elif roll >= 75 and roll < 125:
		nq = "Average (" + str(roll) + ")"
	
	elif roll >= 125 and roll < 150:
		nq = "Sharp (" + str(roll) + ")"
	
	elif roll >= 150 and roll < 175:
		nq = "Superior (" + str(roll) + ")"
	
	elif roll >= 175:
		nq = "Exceptional (" + str(roll) + ")"
	
	return(nq)