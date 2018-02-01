extends Control

var slavelist = {}
var new_slave = preload("New Slave/new slave.tscn").instance()


func _on_Back_pressed():
	get_tree().change_scene("res://game.tscn")


func _on_Buy_Slaves_Button_pressed():
	get_node("Buy Slaves/Buy Slaves Panel").show()
	get_node("Buy Slaves/Buy Slaves Button").hide()
	get_node("Buy Slaves/Finished").show()


func _on_Finished_pressed():
	get_node("Buy Slaves/Buy Slaves Panel").hide()
	get_node("Buy Slaves/Kidnappers' Market").hide()
	get_node("Buy Slaves/Buy Slaves Button").show()
	get_node("Buy Slaves/Finished").hide()


func _on_Kidnappers_Market_pressed():
	get_node("Buy Slaves/Buy Slaves Panel").hide()
	get_node("Buy Slaves/Kidnappers' Market").show()
	get_node("Buy Slaves/Kidnappers' Market/Label").set_text(str(game.km_list.size()) + " slaves available this week")
	display_slave_list(game.km_list,get_node("Buy Slaves/Kidnappers' Market/ScrollContainer/HBoxContainer"))

	print(game.km_list.keys())
	print(game.km_list.keys()[1])


func display_slave_list(list,location):
	#	var wew = TextureFrame.new()
#	add_child(wew)
#	#str()
#	wew.set_texture(load("res://Slaves/Textures/body.png"))
	
	for child in location.get_children():
		child.free()
	
	for i in list:
		
		var button = Button.new()
		location.add_child(button)
		button.set_text(str(i))
		
		var info = Label.new()
		info.set_text(
		"Ethnicity: " + game.km_list[i]["Ethnicity"] + "\n" +
		"Skin Color: " + game.km_list[i]["Skin Color"] + "\n" +
		"Hair Color: " + game.km_list[i]["Hair Color"] + "\n" +
		"Eye Color: " + game.km_list[i]["Eye Color"] + "\n" +
		"Height: " + game.km_list[i]["Height"] + "\n" +
		"Intelligence: " + game.km_list[i]["Intelligence"]
		)
		
		button.add_child(info)
		info.set_pos(Vector2(0,50))
		
		var body = TextureFrame.new()
		body.set_texture(load("res://Slaves/Textures/body.png"))
		button.add_child(body)
		body.set_scale(Vector2(0.4,0.4))
		body.set_pos(Vector2(0,150))
		
		var hair = TextureFrame.new() # Texture frame for hair
		button.add_child(hair)
		hair.set_texture(load("res://Slaves/Textures/" + str(game.km_list[i]["Hair Color"]) + '.png')) # Makes a string out of the value of the ["haircolor"] key to select the name of the appropriate .png file
		hair.set_scale(Vector2(0.4,0.4))
		hair.set_pos(Vector2(0,150))
	
	
	
	
	var spacer = Control.new()
	spacer.set_custom_minimum_size(Vector2(20,20))
	location.add_child(spacer)

func _on_Neighboring_Arcologies_pressed():
	pass # replace with function body


func _on_Unlockable_1_pressed():
	pass # replace with function body
