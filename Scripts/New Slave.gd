extends "res://Scripts/UI.gd" # Connects to the UI script. Now we can call variables, functions, etc. from that script.

var new_name = null
var new_age = null
var new_hair_color = null
var price_modifier = null
var new_intelligence = null
var new_slave_dict = {}
var new_slave_list = []


# CREATE A NEW SLAVE
func default_new_slave():


	# REFRESH INTERMEDIATE {DICTIONARY} AND [ARRAY]
	new_slave_dict = {}
	new_slave_list = []


	# GENERATE FIRST NAME
	randomize() # Randomize engine seed
	var roll_first_name = rand_range(0,1) # Based on the engine's seed, pick a random floating point number between 0 and 1.
	var new_first_name = null # Empty var to be filled with first name
	if roll_first_name >= 0 and roll_first_name < 0.1: # 10% chance
		new_first_name = "Emma"
	elif roll_first_name >= 0.1 and roll_first_name < 0.2: # 10% chance
		new_first_name = "Olivia"
	elif roll_first_name >= 0.2 and roll_first_name < 0.3: # 10% chance
		new_first_name = "Sophia"
	elif roll_first_name >= 0.3 and roll_first_name < 0.4: # 10% chance
		new_first_name = "Ava"
	elif roll_first_name >= 0.4 and roll_first_name < 0.5: # 10% chance
		new_first_name = "Isabella"
	elif roll_first_name >= 0.5 and roll_first_name < 0.6: # 10% chance
		new_first_name = "Mia"
	elif roll_first_name >= 0.6 and roll_first_name < 0.7: # 10% chance
		new_first_name = "Abigail"
	elif roll_first_name >= 0.7 and roll_first_name < 0.8: # 10% chance
		new_first_name = "Emily"
	elif roll_first_name >= 0.8 and roll_first_name < 0.9: # 10% chance
		new_first_name = "Harper"
	elif roll_first_name >= 0.9 and roll_first_name <= 1: # 10% chance
		new_first_name = "Madison"


	# GENERATE LAST NAME
	randomize()
	var roll_last_name = rand_range(0,1) 
	var new_last_name = null
	if roll_last_name >= 0 and roll_last_name < 0.1: # 10% chance
		new_last_name = "Smith"
	elif roll_last_name >= 0.1 and roll_last_name < 0.2: # 10% chance
		new_last_name = "Johnson"
	elif roll_last_name >= 0.2 and roll_last_name < 0.3: # 10% chance
		new_last_name = "Williams"
	elif roll_last_name >= 0.3 and roll_last_name < 0.4: # 10% chance
		new_last_name = "Jones"
	elif roll_last_name >= 0.4 and roll_last_name < 0.5: # 10% chance
		new_last_name = "Brown"
	elif roll_last_name >= 0.5 and roll_last_name < 0.6: # 10% chance
		new_last_name = "Davis"
	elif roll_last_name >= 0.6 and roll_last_name < 0.7: # 10% chance
		new_last_name = "Miller"
	elif roll_last_name >= 0.7 and roll_last_name < 0.8: # 10% chance
		new_last_name = "Wilson"
	elif roll_last_name >= 0.8 and roll_last_name < 0.9: # 10% chance
		new_last_name = "Moore"
	elif roll_last_name >= 0.9 and roll_last_name <= 1: # 10% chance
		new_last_name = "Anderson"


	# CREATE FULL NAME
	
	new_name = new_first_name + " " + new_last_name # The slave's name will be the first name variable, a space, and the last name variable


	# NOTE: This system uses slave's names as their dictionary key. Duplicate names cannot exist. Right now there are 100 possible names with an equal chance to get any of them.
	# CHECK TO SEE IF NAME ALREADY EXISTS
	while slave_list.has(str(new_name)): # If the new name already exists in the player's slave_list,
		
		# RECREATE NAME
		randomize()
		roll_first_name = rand_range(0,1)
		new_first_name = null
		if roll_first_name >= 0 and roll_first_name < 0.1: # 10% chance
			new_first_name = "Emma"
		elif roll_first_name >= 0.1 and roll_first_name < 0.2: # 10% chance
			new_first_name = "Olivia"
		elif roll_first_name >= 0.2 and roll_first_name < 0.3: # 10% chance
			new_first_name = "Sophia"
		elif roll_first_name >= 0.3 and roll_first_name < 0.4: # 10% chance
			new_first_name = "Ava"
		elif roll_first_name >= 0.4 and roll_first_name < 0.5: # 10% chance
			new_first_name = "Isabella"
		elif roll_first_name >= 0.5 and roll_first_name < 0.6: # 10% chance
			new_first_name = "Mia"
		elif roll_first_name >= 0.6 and roll_first_name < 0.7: # 10% chance
			new_first_name = "Abigail"
		elif roll_first_name >= 0.7 and roll_first_name < 0.8: # 10% chance
			new_first_name = "Emily"
		elif roll_first_name >= 0.8 and roll_first_name < 0.9: # 10% chance
			new_first_name = "Harper"
		elif roll_first_name >= 0.9 and roll_first_name <= 1: # 10% chance
			new_first_name = "Madison"
			
		# GENERATE LAST NAME
		randomize()
		roll_last_name = rand_range(0,1) 
		new_last_name = null
		if roll_last_name >= 0 and roll_last_name < 0.1: # 10% chance
			new_last_name = "Smith"
		elif roll_last_name >= 0.1 and roll_last_name < 0.2: # 10% chance
			new_last_name = "Johnson"
		elif roll_last_name >= 0.2 and roll_last_name < 0.3: # 10% chance
			new_last_name = "Williams"
		elif roll_last_name >= 0.3 and roll_last_name < 0.4: # 10% chance
			new_last_name = "Jones"
		elif roll_last_name >= 0.4 and roll_last_name < 0.5: # 10% chance
			new_last_name = "Brown"
		elif roll_last_name >= 0.5 and roll_last_name < 0.6: # 10% chance
			new_last_name = "Davis"
		elif roll_last_name >= 0.6 and roll_last_name < 0.7: # 10% chance
			new_last_name = "Miller"
		elif roll_last_name >= 0.7 and roll_last_name < 0.8: # 10% chance
			new_last_name = "Wilson"
		elif roll_last_name >= 0.8 and roll_last_name < 0.9: # 10% chance
			new_last_name = "Moore"
		elif roll_last_name >= 0.9 and roll_last_name <= 1: # 10% chance
			new_last_name = "Anderson"
			
		# RECREATE FULL NAME
		new_name = new_first_name + " " + new_last_name
		pass
		# This indent defines the end of the while loop
	# If the name does not already exist, keep going.


	# BASE PRICE
	# Modified by slave attributes
	price_modifier = 2000


	# GENERATE AGE
	randomize()
	new_age = randi() %41+18 # The slave's age will be a random integer between 18 and 59
	if new_age >= 18 and new_age <= 20:
		price_modifier += 1000
	elif new_age > 20 and new_age <= 25:
		price_modifier += 500
	elif new_age > 25:
		price_modifier += 0


	# GENERATE HAIR COLOR
	randomize()
	var roll_hair_color = rand_range(0,18)
	if roll_hair_color >= 0 and roll_hair_color < 1: # 60% chance
		new_hair_color = "brown"
		price_modifier *= 1
	elif roll_hair_color >= 1 and roll_hair_color < 2: # 30% chance
		new_hair_color = "light brown"
		price_modifier *= 1
	elif roll_hair_color >= 2 and roll_hair_color < 3: # 10% chance
		new_hair_color = "dark brown"
		price_modifier *= 1
	elif roll_hair_color >= 3 and roll_hair_color < 4: # 10% chance
		new_hair_color = "black"
		price_modifier *= 1
	elif roll_hair_color >= 4 and roll_hair_color < 5: # 10% chance
		new_hair_color = "auburn"
		price_modifier *= 1
	elif roll_hair_color >= 5 and roll_hair_color < 6: # 10% chance
		new_hair_color = "ginger"
		price_modifier *= 1
	elif roll_hair_color >= 6 and roll_hair_color < 7: # 10% chance
		new_hair_color = "hazel"
		price_modifier *= 1
	elif roll_hair_color >= 7 and roll_hair_color < 8: # 10% chance
		new_hair_color = "copper"
		price_modifier *= 1
	elif roll_hair_color >= 8 and roll_hair_color < 9: # 10% chance
		new_hair_color = "red"
		price_modifier *= 2
	elif roll_hair_color >= 9 and roll_hair_color < 10: # 10% chance
		new_hair_color = "strawberry"
		price_modifier *= 1.5
	elif roll_hair_color >= 10 and roll_hair_color < 11: # 10% chance
		new_hair_color = "blond"
		price_modifier *= 1.5
	elif roll_hair_color >= 11 and roll_hair_color < 12: # 10% chance
		new_hair_color = "burgundy"
		price_modifier *= 2
	elif roll_hair_color >= 12 and roll_hair_color < 13: # 10% chance
		new_hair_color = "golden"
		price_modifier *= 1
	elif roll_hair_color >= 13 and roll_hair_color < 14: # 10% chance
		new_hair_color = "platinum"
		price_modifier *= 1
	elif roll_hair_color >= 14 and roll_hair_color < 15: # 10% chance
		new_hair_color = "dark grey"
		price_modifier *= 1
	elif roll_hair_color >= 15 and roll_hair_color < 16: # 10% chance
		new_hair_color = "grey"
		price_modifier *= 1
	elif roll_hair_color >= 16 and roll_hair_color < 17: # 10% chance
		new_hair_color = "silver"
		price_modifier *= 1
	elif roll_hair_color >= 17 and roll_hair_color <= 18: # 10% chance
		new_hair_color = "white"
		price_modifier *= 1


	# GENERATE INTELLIGENCE
	randomize()
	var roll_intelligence = rand_range(0,1)
	if roll_intelligence <= 1 and roll_intelligence >= 0.95: # 5% chance to be brilliant
		new_intelligence = "brilliant"
		price_modifier *= 3
	elif roll_intelligence < 0.95 and roll_intelligence >= 0.85: # 10% chance to be very smart
		new_intelligence = "very smart"
		price_modifier *= 2
	elif roll_intelligence < 0.85 and roll_intelligence >= 0.7: # 15% chance to be smart
		new_intelligence = "smart"
		price_modifier *= 1.5
	elif roll_intelligence < 0.7 and roll_intelligence >= 0.45: # 25% chance to be average
		new_intelligence = "average"
		price_modifier *= 1
	elif roll_intelligence < 0.45 and roll_intelligence >= 0.25: # 20% chance to be stupid
		new_intelligence = "stupid"
		price_modifier *= 1
	elif roll_intelligence < 0.25 and roll_intelligence >= 0.1: # 15% chance to be very stupid
		new_intelligence = "very stupid"
		price_modifier *= 1
	elif roll_intelligence < 0.1 and roll_intelligence >= 0: # 10% chance to be moronic
		new_intelligence = "moronic"
		price_modifier *= 1


	# ADD KEYS AND VALUES TO INTERMEDIATE DICTIONARY
	new_slave_dict[new_name] = { # In {dictionary} "new_slave_dict", add the [key] "new_name", with a {dictionary} as its [value]. It's a {dictionary} inside a {dictionary}.
	name = new_name, # In this new {dictionary}, add [key] "name", with the [value] "new_name"
	nickname = null, # If present, the nickname will be shown instead of the first and last name in the UI (Not yet implemented.)
	age = new_age,
	hair_color = new_hair_color,
	intelligence = new_intelligence
	# Add more slave variables here, and create the random generation modules for them above.
	}


	# APPEND SLAVE'S NAME TO INTERMEDIATE ARRAY
	new_slave_list.append(new_name) # And append slave to the "new_slave_list" [array]


	# REFRESH GENERATED SLAVE DISPLAY
	for N in newslavecontainer.get_children(): # For all child (N)odes of node SlaveHBox:
		newslavecontainer.remove_child(N) # Remove all (N)odes. (Refreshes display.)


	# GENERATED SLAVE DISPLAY
	for i in new_slave_list: # Iterate through all (i)tems in the new_slave_list [array],
		# Create buttons with dynamic internal elements for each (i)tem.
		
		var node_container = Container.new() # New Container node
		newslavecontainer.add_child(node_container) # Add the Container as a child of (inside of) newslavecontainer.
		node_container.set_name(str(i) + "_container") # Make a string out of the iterated (i)tem, add "_container" to that string, and set that string as the name of the new Container node
		
		
		var node_vbox = VBoxContainer.new() # New VBox node to separate elements automatically
		node_container.add_child(node_vbox)
		node_vbox.set_name(str(i) + "_vbox")
		
		
		var node_spacer = Control.new() # New Control node used as a spacer to push everything else in the VBox down.
		node_vbox.add_child(node_spacer)
		node_spacer.set_name(str(i) + "_spacer")
		node_spacer.set_custom_minimum_size(Vector2(0,40)) # Vector2 is X Y values.
		
		var node_centercontainer = HBoxContainer.new() # Being used with a spacer inside of it as a pseudo CenterContainer for now.
		node_vbox.add_child(node_centercontainer)
		node_centercontainer.set_name(str(i) + "_centercontainer")
		
		var node_spacer2 = Control.new() # New Control node used as a spacer to push everything else in the HBox to the right.
		node_centercontainer.add_child(node_spacer2)
		node_spacer2.set_name(str(i) + "_spacer2")
		node_spacer2.set_custom_minimum_size(Vector2(150,0)) # Push everything else in the HBox (kinda) towards the center. Sloppy.
		
		var node_vbox2 = VBoxContainer.new() # ANOTHER VBox, inside the HBox, thats inside the VBox, inside the Container.
		# But now, anything we put inside this VBox will be displayed in a perfectly vertical column.
		node_centercontainer.add_child(node_vbox2)
		node_vbox2.set_name(str(i) + "_vbox2")
		
		var node_title = Label.new() # This is an empty label to display the slave's name at the top of the Container.
		node_vbox2.add_child(node_title)
		node_title.set_name(str(i) + "_title")
		node_title.set_text(str(new_slave_dict[i]["name"])) # in the {dictionary} "slaves", get the [item] we are displaying, get the [key] "name" for that item, turn its value into a string, and display that string.
		
		var node_container = Container.new() # This is an empty container for the images in the slave model.
		node_vbox.add_child(node_container)
		node_container.set_name(str(i) + "_container")
		
		var node_body = TextureFrame.new() # TextureFrame displays a texture
		node_container.add_child(node_body)
		node_body.set_name(str(i) + "_body")
		node_body.set_texture(load('res://Textures/Slaves/body.png')) # Universal body texture
		node_body.set_pos(Vector2(0,0)) # Sets position to X:0 Y:0 (For future positioning.)
		node_body.set_margin(0,0) # (For future positioning.)
		
		var node_hair = TextureFrame.new() # Texture frame for hair
		node_container.add_child(node_hair)
		node_hair.set_name(str(i) + "_hair")
		node_hair.set_texture(load('res://Textures/Slaves/' + str(new_slave_dict[i]["hair_color"]) + '.png')) # Makes a string out of the value of the ["hair_color"] key to select the name of the appropriate .png file
		node_hair.set_pos(Vector2(0,0))
		node_hair.set_margin(0,0)
		
		# Display the slave's info from {dictionary} new_slave_dict
		newslaveinfo.set_text(str(new_slave_dict))
		newslaveprice.set_text("Price: " + str(price_modifier))


func buy_slave():
	slave_dict[new_name] = {
	name = new_name, # In this new {dictionary}, add [key] "name", with the [value] "new_name"
	nickname = null, # If present, the nickname will be shown instead of the first and last name in the UI (Not yet implemented.)
	age = new_age,
	hair_color = new_hair_color,
	intelligence = new_intelligence
	}
	slave_list.append(new_name)