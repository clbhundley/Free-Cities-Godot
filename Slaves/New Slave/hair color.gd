extends Node

# GENERATE HAIR COLOR
static func new(ethnicity):
	
	randomize()
	
	print(ethnicity)
	
	var hair_color = null
	
	var roll = rand_range(0,18)
	
	if roll >= 0 and roll < 1: # 60% chance
		hair_color = "brown"
		
	elif roll >= 1 and roll < 2: # 30% chance
		hair_color = "light brown"
		
	elif roll >= 2 and roll < 3: # 10% chance
		hair_color = "dark brown"
	
	elif roll >= 3 and roll < 4: # 10% chance
		hair_color = "black"
	
	elif roll >= 4 and roll < 5: # 10% chance
		hair_color = "auburn"
	
	elif roll >= 5 and roll < 6: # 10% chance
		hair_color = "ginger"
	
	elif roll >= 6 and roll < 7: # 10% chance
		hair_color = "hazel"
	
	elif roll >= 7 and roll < 8: # 10% chance
		hair_color = "copper"
	
	elif roll >= 8 and roll < 9: # 10% chance
		hair_color = "red"
	
	elif roll >= 9 and roll < 10: # 10% chance
		hair_color = "strawberry"
	
	elif roll >= 10 and roll < 11: # 10% chance
		hair_color = "blond"
	
	elif roll >= 11 and roll < 12: # 10% chance
		hair_color = "burgundy"
	
	elif roll >= 12 and roll < 13: # 10% chance
		hair_color = "golden"
	
	elif roll >= 13 and roll < 14: # 10% chance
		hair_color = "platinum"
	
	elif roll >= 14 and roll < 15: # 10% chance
		hair_color = "dark grey"
	
	elif roll >= 15 and roll < 16: # 10% chance
		hair_color = "grey"
	
	elif roll >= 16 and roll < 17: # 10% chance
		hair_color = "silver"
	
	elif roll >= 17 and roll <= 18: # 10% chance
		hair_color = "white"
	
	return(hair_color)