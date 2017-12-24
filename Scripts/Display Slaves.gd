extends "res://Scripts/UI.gd" # Connects to the UI script. Now we can call variables, functions, etc. from that script.


# DISPLAY YOUR SLAVES
func player_slaves():


	# REFRESH DISPLAY
	for N in slavehbox.get_children(): # For all child (N)odes of node SlaveHBox:
		slavehbox.remove_child(N) # Remove all (N)odes. (Refreshes display.)


	for i in slave_list:# Iterate through all (i)tems in the slave_list [array],
		# Create buttons with dynamic internal elements for each (i)tem.
		
		var node_button = TextureButton.new() # New TextureButton node
		slavehbox.add_child(node_button) # Add the TextureButton node as a child of (inside of) slavehbox.
		node_button.set_name(str(i) + "_button") # Set the name of the TextureButton node to, make a string out of the (i)tem we are talking about and add "_button" to the end.
		node_button.set_normal_texture(load('res://Textures/Slaves/button1.png')) # Set TextureButton normal texture
		node_button.set_hover_texture(load('res://Textures/Slaves/button2.png')) # Set Texture Button mouse-hovered texture
		node_button.set_texture_scale(Vector2(0.8,0.8)) # Scale it down a bit because I'm too lazy to edit it in photoshop
		# After making our changes to the TextureButton, we define it using the name we set on line 94.
		# Notice that its path shows it being inside slavehbox, since we added it as a child of slavehbox.
		var node_button = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button")
		
		var node_vbox = VBoxContainer.new() # New VBox node to separate buttons automatically
		node_button.add_child(node_vbox)
		node_vbox.set_name(str(i) + "_vbox")
		var node_vbox = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox")
		
		var node_spacer = Control.new() # New Control node used as a spacer to push everything in the VBox below it down.
		node_vbox.add_child(node_spacer)
		node_spacer.set_name(str(i) + "_spacer")
		var node_spacer = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_spacer")
		node_spacer.set_custom_minimum_size(Vector2(0,40)) # Vector2 is X Y values.
		
		var node_centercontainer = HBoxContainer.new() # Being used with a spacer inside of it as a pseudo CenterContainer for now.
		node_vbox.add_child(node_centercontainer)
		node_centercontainer.set_name(str(i) + "_centercontainer")
		var node_centercontainer = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_centercontainer")
		
		var node_spacer2 = Control.new()
		node_centercontainer.add_child(node_spacer2)
		node_spacer2.set_name(str(i) + "_spacer2")
		var node_spacer2 = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_centercontainer/" + str(i) + "_spacer2")
		node_spacer2.set_custom_minimum_size(Vector2(150,0)) # Push everything else in the HBox (kinda) towards the center. Sloppy.
		
		var node_vbox2 = VBoxContainer.new() # ANOTHER VBox, inside the HBox, thats inside the VBox, inside the TextureButton.
		# But now, anything we put inside this VBox will be displayed in a perfectly vertical column.
		node_centercontainer.add_child(node_vbox2)
		node_vbox2.set_name(str(i) + "_vbox2")
		var node_vbox2 = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_centercontainer/" + str(i) + "_vbox2")
		
		var node_title = Label.new() # This is an empty label to display the slave's name at the top of the button.
		node_vbox2.add_child(node_title)
		node_title.set_name(str(i) + "_title")
		var node_title = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_centercontainer/" + str(i) + "_vbox2/" + str(i) + "_title")
		node_title.set_text(str(slave_dict[i]["name"])) # in the {dictionary} "slaves", get the [item] we are displaying, get the [key] "name" for that item, turn its value into a string, and display that string.
		
		var node_container = Container.new() # This is an empty container for the images in the slave model.
		node_vbox.add_child(node_container)
		node_container.set_name(str(i) + "_container")
		var node_container = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_container")
		
		var node_body = TextureFrame.new() # TextureFrame displays a texture
		node_container.add_child(node_body)
		node_body.set_name(str(i) + "_body")
		var node_body = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_container/" + str(i) + "_body")
		node_body.set_texture(load('res://Textures/Slaves/body.png')) # Universal body texture
		node_body.set_pos(Vector2(0,0)) # Sets position to X:0 Y:0 (For future positioning.)
		node_body.set_margin(0,0) # (For future positioning.)
		
		var node_hair = TextureFrame.new() # Texture frame for hair
		node_container.add_child(node_hair)
		node_hair.set_name(str(i) + "_hair")
		var node_hair = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox/" + str(i) + "_button/" + str(i) + "_vbox/" + str(i) + "_container/" + str(i) + "_hair")
		node_hair.set_texture(load('res://Textures/Slaves/' + str(slave_dict[i]["hair_color"]) + '.png')) # Makes a string out of the value of the ["haircolor"] key to select the name of the appropriate .png file
		node_hair.set_pos(Vector2(0,0))
		node_hair.set_margin(0,0)
