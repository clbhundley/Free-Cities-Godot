extends "res://Scripts/UI.gd" # Connects to the UI script. Now we can call variables, functions, etc. from that script.

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


# CREATE A NEW SLAVE
func Generate_Slave():

	# UI VISIBILITY CONTROLS
	newslavecontainer.show()
	newslaveinfo.show()
	add_slave.show()


	# REFRESH INTERMEDIATE {DICTIONARY} AND [ARRAY]
	slavesnew = {}
	slavelistnew = []


	# GENERATE FIRST NAME
	randomize() # Randomize engine seed
	var firstname_gen = rand_range(0,1) # Based on the engine's seed, pick a random floating point number between 0 and 1.
	var randfirst_name = null # Empty var to be filled with first name
	if firstname_gen >= 0 and firstname_gen < 0.1: # 10% chance
		randfirst_name = "Emma"
	elif firstname_gen >= 0.1 and firstname_gen < 0.2: # 10% chance
		randfirst_name = "Olivia"
	elif firstname_gen >= 0.2 and firstname_gen < 0.3: # 10% chance
		randfirst_name = "Sophia"
	elif firstname_gen >= 0.3 and firstname_gen < 0.4: # 10% chance
		randfirst_name = "Ava"
	elif firstname_gen >= 0.4 and firstname_gen < 0.5: # 10% chance
		randfirst_name = "Isabella"
	elif firstname_gen >= 0.5 and firstname_gen < 0.6: # 10% chance
		randfirst_name = "Mia"
	elif firstname_gen >= 0.6 and firstname_gen < 0.7: # 10% chance
		randfirst_name = "Abigail"
	elif firstname_gen >= 0.7 and firstname_gen < 0.8: # 10% chance
		randfirst_name = "Emily"
	elif firstname_gen >= 0.8 and firstname_gen < 0.9: # 10% chance
		randfirst_name = "Harper"
	elif firstname_gen >= 0.9 and firstname_gen <= 1: # 10% chance
		randfirst_name = "Madison"


	# GENERATE LAST NAME
	randomize()
	var lastname_gen = rand_range(0,1) 
	var randlast_name = null
	if lastname_gen >= 0 and lastname_gen < 0.1: # 10% chance
		randlast_name = "Smith"
	elif lastname_gen >= 0.1 and lastname_gen < 0.2: # 10% chance
		randlast_name = "Johnson"
	elif lastname_gen >= 0.2 and lastname_gen < 0.3: # 10% chance
		randlast_name = "Williams"
	elif lastname_gen >= 0.3 and lastname_gen < 0.4: # 10% chance
		randlast_name = "Jones"
	elif lastname_gen >= 0.4 and lastname_gen < 0.5: # 10% chance
		randlast_name = "Brown"
	elif lastname_gen >= 0.5 and lastname_gen < 0.6: # 10% chance
		randlast_name = "Davis"
	elif lastname_gen >= 0.6 and lastname_gen < 0.7: # 10% chance
		randlast_name = "Miller"
	elif lastname_gen >= 0.7 and lastname_gen < 0.8: # 10% chance
		randlast_name = "Wilson"
	elif lastname_gen >= 0.8 and lastname_gen < 0.9: # 10% chance
		randlast_name = "Moore"
	elif lastname_gen >= 0.9 and lastname_gen <= 1: # 10% chance
		randlast_name = "Anderson"


	# CREATE FULL NAME
	rand_name = randfirst_name + " " + randlast_name # The slave's name will be the first name variable, a space, and the last name variable


	# NOTE: This system uses slave's names as their dictionary key. Duplicate names cannot exist. Right now there are 100 possible names with an equal chance to get any of them.
	# CHECK TO SEE IF NAME ALREADY EXISTS
	while slavelist.has(str(rand_name)): # If the new name already exists in the player's slavelist,
		
		# RECREATE NAME
		randomize()
		firstname_gen = rand_range(0,1)
		randfirst_name = null
		if firstname_gen >= 0 and firstname_gen < 0.1: # 10% chance
			randfirst_name = "Emma"
		elif firstname_gen >= 0.1 and firstname_gen < 0.2: # 10% chance
			randfirst_name = "Olivia"
		elif firstname_gen >= 0.2 and firstname_gen < 0.3: # 10% chance
			randfirst_name = "Sophia"
		elif firstname_gen >= 0.3 and firstname_gen < 0.4: # 10% chance
			randfirst_name = "Ava"
		elif firstname_gen >= 0.4 and firstname_gen < 0.5: # 10% chance
			randfirst_name = "Isabella"
		elif firstname_gen >= 0.5 and firstname_gen < 0.6: # 10% chance
			randfirst_name = "Mia"
		elif firstname_gen >= 0.6 and firstname_gen < 0.7: # 10% chance
			randfirst_name = "Abigail"
		elif firstname_gen >= 0.7 and firstname_gen < 0.8: # 10% chance
			randfirst_name = "Emily"
		elif firstname_gen >= 0.8 and firstname_gen < 0.9: # 10% chance
			randfirst_name = "Harper"
		elif firstname_gen >= 0.9 and firstname_gen <= 1: # 10% chance
			randfirst_name = "Madison"
			
		# GENERATE LAST NAME
		randomize()
		lastname_gen = rand_range(0,1) 
		randlast_name = null
		if lastname_gen >= 0 and lastname_gen < 0.1: # 10% chance
			randlast_name = "Smith"
		elif lastname_gen >= 0.1 and lastname_gen < 0.2: # 10% chance
			randlast_name = "Johnson"
		elif lastname_gen >= 0.2 and lastname_gen < 0.3: # 10% chance
			randlast_name = "Williams"
		elif lastname_gen >= 0.3 and lastname_gen < 0.4: # 10% chance
			randlast_name = "Jones"
		elif lastname_gen >= 0.4 and lastname_gen < 0.5: # 10% chance
			randlast_name = "Brown"
		elif lastname_gen >= 0.5 and lastname_gen < 0.6: # 10% chance
			randlast_name = "Davis"
		elif lastname_gen >= 0.6 and lastname_gen < 0.7: # 10% chance
			randlast_name = "Miller"
		elif lastname_gen >= 0.7 and lastname_gen < 0.8: # 10% chance
			randlast_name = "Wilson"
		elif lastname_gen >= 0.8 and lastname_gen < 0.9: # 10% chance
			randlast_name = "Moore"
		elif lastname_gen >= 0.9 and lastname_gen <= 1: # 10% chance
			randlast_name = "Anderson"
			
		# RECREATE FULL NAME
		rand_name = randfirst_name + " " + randlast_name
		pass
		# This indent defines the end of the while loop
	# If the name does not already exist, keep going.


	# GENERATE AGE
	randomize()
	age_gen = randi() %41+18 # The slave's age will be a random integer between 18 and 59


	# GENERATE HAIR COLOR
	randomize()
	var haircolor_gen = rand_range(0,1)
	if haircolor_gen >= 0 and haircolor_gen < 0.3: # 30% chance
		rand_haircolor = "black"
	elif haircolor_gen >= 0.3 and haircolor_gen < 0.4: # 10% chance
		rand_haircolor = "blond"
	elif haircolor_gen >= 0.4 and haircolor_gen <= 1: # 60% chance
		rand_haircolor = "brown"


	# ADD KEYS AND VALUES TO INTERMEDIATE DICTIONARY
	slavesnew[rand_name] = { # In {dictionary} "slaves", add the [key] "rand_name", with a {dictionary} as its [value]. It's a {dictionary} inside a {dictionary}.
	name = rand_name, # In this new {dictionary}, add [key] "name", with the [value] "rand_name"
	nickname = null, # If present, the nickname will be shown instead of the first and last name in the UI (Not yet implemented.)
	age = age_gen,
	haircolor = rand_haircolor
	# Add more slave variables here, and create the random generation modules for them above.
	}


	# APPEND SLAVE'S NAME TO INTERMEDIATE ARRAY
	slavelistnew.append(rand_name) # And append slave to the "slavelist" [array] in the Player node


	# REFRESH GENERATED SLAVE DISPLAY
	for N in newslavecontainer.get_children(): # For all child (N)odes of node SlaveHBox:
		newslavecontainer.remove_child(N) # Remove all (N)odes. (Refreshes display.)


	# GENERATED SLAVE DISPLAY
	for i in slavelistnew: # Iterate through all (i)tems in the slavelistnew [array],
		# Create buttons with dynamic internal elements for each (i)tem.
		
		var node_container = Container.new() # New Container node
		newslavecontainer.add_child(node_container) # Add the Container as a child of (inside of) newslavecontainer.
		node_container.set_name(str(i) + "_container") # Make a string out of the iterated (i)tem, add "_container" to that string, and set that string as the name of the new Container node
		var node_container = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container")
		
		var node_vbox = VBoxContainer.new() # New VBox node to separate elements automatically
		node_container.add_child(node_vbox)
		node_vbox.set_name(str(i) + "_vbox")
		var node_vbox = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox")
		
		var node_spacer = Control.new() # New Control node used as a spacer to push everything else in the VBox down.
		node_vbox.add_child(node_spacer)
		node_spacer.set_name(str(i) + "_spacer")
		var node_spacer = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_spacer")
		node_spacer.set_custom_minimum_size(Vector2(0,40)) # Vector2 is X Y values.
		
		var node_centercontainer = HBoxContainer.new() # Being used with a spacer inside of it as a pseudo CenterContainer for now.
		node_vbox.add_child(node_centercontainer)
		node_centercontainer.set_name(str(i) + "_centercontainer")
		var node_centercontainer = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_centercontainer")
		
		var node_spacer2 = Control.new() # New Control node used as a spacer to push everything else in the HBox to the right.
		node_centercontainer.add_child(node_spacer2)
		node_spacer2.set_name(str(i) + "_spacer2")
		var node_spacer2 = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_centercontainer/" + str(i) + "_spacer2")
		node_spacer2.set_custom_minimum_size(Vector2(150,0)) # Push everything else in the HBox (kinda) towards the center. Sloppy.
		
		var node_vbox2 = VBoxContainer.new() # ANOTHER VBox, inside the HBox, thats inside the VBox, inside the Container.
		# But now, anything we put inside this VBox will be displayed in a perfectly vertical column.
		node_centercontainer.add_child(node_vbox2)
		node_vbox2.set_name(str(i) + "_vbox2")
		var node_vbox2 = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_centercontainer/" + str(i) + "_vbox2")
		
		var node_title = Label.new() # This is an empty label to display the slave's name at the top of the Container.
		node_vbox2.add_child(node_title)
		node_title.set_name(str(i) + "_title")
		var node_title = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_centercontainer/" + str(i) + "_vbox2/" + str(i) + "_title")
		node_title.set_text(str(slavesnew[i]["name"])) # in the {dictionary} "slaves", get the [item] we are displaying, get the [key] "name" for that item, turn its value into a string, and display that string.
		
		var node_container = Container.new() # This is an empty container for the images in the slave model.
		node_vbox.add_child(node_container)
		node_container.set_name(str(i) + "_container")
		var node_container = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_container")
		
		var node_body = TextureFrame.new() # TextureFrame displays a texture
		node_container.add_child(node_body)
		node_body.set_name(str(i) + "_body")
		var node_body = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_container/" + str(i) + "_body")
		node_body.set_texture(load('res://Textures/Slaves/empty.png')) # Universal body texture
		node_body.set_pos(Vector2(0,0)) # Sets position to X:0 Y:0 (For future positioning.)
		node_body.set_margin(0,0) # (For future positioning.)
		
		var node_hair = TextureFrame.new() # Texture frame for hair
		node_container.add_child(node_hair)
		node_hair.set_name(str(i) + "_hair")
		var node_hair = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer/" + str(i) + "_container/" + str(i) + "_vbox/" + str(i) + "_container/" + str(i) + "_hair")
		node_hair.set_texture(load('res://Textures/Slaves/' + str(slavesnew[i]["haircolor"]) + '.png')) # Makes a string out of the value of the ["haircolor"] key to select the name of the appropriate .png file
		node_hair.set_pos(Vector2(0,0))
		node_hair.set_margin(0,0)
		
		# Display the slave's info from {dictionary} slavesnew
		newslaveinfo.set_text(str(slavesnew))
